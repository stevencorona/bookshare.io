class OrdersController < ApplicationController

  def new
    redirect_to order_path(@order) if @order.duplicate?
  end

  def shipping
    @order.name     = params[:order][:name]
    @order.address1 = params[:order][:address1]
    @order.address2 = params[:order][:address2]
    @order.city     = params[:order][:city]
    @order.state    = params[:order][:state]
    @order.zip      = params[:order][:zip]
    @order.country  = params[:order][:country]

    # TODO: Handle error case
    @order.save!
    @order.shipment_manifest!

    redirect_to payment_orders_path
  end

  def payment
    @shipment = HandlingCalculator.new(@order)
    @shipment.calculate

    @books = @order.books
  end

  def create

    # Prevent duplicate submission
    return redirect_to order_path(@order) if @order.paid?

    @order.email = params[:email]
    @order.token = params[:token]

    @shipment = HandlingCalculator.new(@order)
    @shipment.donate(300) if params[:donation]
    @shipment.calculate

    @order.total_amount    = @shipment.total
    @order.donation_amount = @shipment.donation_rate

    redirect_to order_path

    if @order.save
      @payment = Payment.new(@order)
      @payment.charge

      @order.reserve_books
      @order.paid!

      OrderMailer.thank_you_email(@order).deliver

      cookies[:order] = {
        value: @order.id,
        expires: 1.year.from_now
      }
    else
      @order.duplicate!
    end

    redirect_to order_path(@order)

  rescue Stripe::CardError => e
    @order.unreserve_books
  end

  def show
    @order ||= Order.find(params[:id])

    render :duplicate if @order.duplicate?
  end

end
