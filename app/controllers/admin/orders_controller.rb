class Admin::OrdersController < AdminController
  def index
    @orders = Order.where("status = ?", :paid).order("updated_at")
  end

  def prepare
    @order = Order.find(params[:id])

    if params[:box] && params[:weight]
      @shipment = @order.shipment(params[:weight], params[:box])
    end
  end

  def buy
    @order = Order.find(params[:id])

    if params[:box] && params[:weight]
      @shipment = @order.shipment(params[:weight], params[:box])
    end

    @shipment.buy(
      :rate => @shipment.lowest_rate
    )

    @order.ship!

  end
end
