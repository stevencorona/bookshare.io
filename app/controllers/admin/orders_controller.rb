class Admin::OrdersController < AdminController
  def index
    @orders = Order.where("status = ?", :paid)
  end
end
