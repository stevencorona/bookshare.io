class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :setup_session

  private
  def setup_session
    session[:books] = [] if session[:books].nil?
  end

end
