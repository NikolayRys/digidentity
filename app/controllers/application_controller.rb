class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end
end
