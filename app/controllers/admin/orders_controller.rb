class Admin::OrdersController < AdminController
  def index
    @orders = Order.where("status = ?", :paid).order("updated_at")
  end

  def prepare
    @order = Order.find(params[:id])

    if params[:box] && params[:weight]
      @shipment = @order.shipment(params[:weight], params[:box])
      @shipment.rates.each do |rate|
        if rate.service == "Priority"
          @rate = rate
        end
      end
    end
  end

  def buy
    @order = Order.find(params[:id])

    if params[:box] && params[:weight]
      @shipment = @order.shipment(params[:weight], params[:box])
    end

    @shipment.rates.each do |rate|
      if rate.service == "Priority"
        @rate = rate
      end
    end

    @shipment.buy(
      :rate => @rate
    )

    @order.ship!

  end
end
