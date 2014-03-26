class Admin::SessionsController < AdminController
  skip_before_filter :authenticate!

  def new
    redirect_to admin_orders_path if session[:admin] == true
  end

  def create
    if params[:username] == ENV['ADMIN_USERNAME'] && params[:password] == ENV['ADMIN_PASSWORD']
      session[:admin] = true
      redirect_to admin_orders_path
    else
      flash[:error] = true
      render :new
    end
  end

end
