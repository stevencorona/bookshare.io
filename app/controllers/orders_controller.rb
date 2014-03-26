class OrdersController < ApplicationController

  def new
    redirect_to order_path(@order.uuid) if @order.duplicate?
  end

  def shipping
    @order.name     = params[:order][:name]
    @order.address1 = params[:order][:address1]
    @order.address2 = params[:order][:address2]
    @order.city     = params[:order][:city]
    @order.state    = params[:order][:state]
    @order.zip      = params[:order][:zip]
    @order.country  = "United States of America" # Force country for now

    # TODO: Handle error case
    if @order.save
      @order.shipment_manifest!
      redirect_to payment_orders_path
    else
      render :new
    end
  end

  def payment
    @shipment = HandlingCalculator.new(@order)
    @shipment.calculate

    @books = @order.books
  end

  def create

    # Prevent duplicate submission
    return redirect_to order_path(@order.uuid) if @order.paid?

    @order.email = params[:email]
    @order.token = params[:token]

    @shipment = HandlingCalculator.new(@order)
    @shipment.donate(300) if params[:donation]
    @shipment.calculate

    @order.total_amount    = @shipment.total
    @order.donation_amount = @shipment.donation_rate

    if @order.save
      @payment = Payment.new(@order)
      @payment.charge

      @order.paid!

      @snagged = []

      @order.items.each do |item|
        begin
          item.book.reserve!
          item.status = "reserved"
          item.save
        rescue Exception
          item.status = "snagged"
          item.save
        end
      end

      OrderMailer.thank_you_email(@order).deliver

      cookies[:order] = {
        value: @order.id,
        expires: 1.year.from_now
      }
    else
      @order.email += "DUPLICATE"
      @order.duplicate!
    end

    redirect_to order_path(@order.uuid)

  rescue Stripe::CardError => e
    @order.unreserve_books
  end

  def show
    @order = Order.find_by_uuid(params[:id])

    render :duplicate if @order.duplicate?
  end

end
