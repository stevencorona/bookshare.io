class Admin::OrdersController < AdminController
  def index
    @orders = Order.where("status = ?", :paid).order("updated_at")
  end
end
