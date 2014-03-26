class AdminController < ApplicationController
  before_filter :authenticate!

  def authenticate!
    redirect_to new_admin_session_path unless session[:admin] == true
  end

end
