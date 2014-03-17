class OrdersController < ApplicationController

  def new
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
    @order.email = params[:email]
    @order.token = params[:token]

    @shipment = HandlingCalculator.new(@order)
    @shipment.donate(300) if params[:donation]
    @shipment.calculate

    @order.total_amount    = @shipment.total
    @order.donation_amount = @shipment.donation_rate

    @order.save

    @payment = Payment.new(@order)
    @payment.charge

    @order.reserve_books
    @order.paid!

    cookies[:order] = {
      value: @order.id,
      expires: 1.year.from_now
    }

    redirect_to order_path(@order)

  rescue Stripe::CardError => e
    @order.unreserve_books
  end

  def show
    @order ||= Order.find(params[:id])
  end

end
