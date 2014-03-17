class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :setup_order

  private
  def setup_order
    @order          = Order.find_by_id(session[:order]) || Order.find_by_id(cookies[:order]) || Order.create!
    session[:order] = @order.id
  end

end
