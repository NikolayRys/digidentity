class SessionsController < ApplicationController

  # Log in menu
  def new
    @users = User.all
  end

  # Log in
  def create
    user = User.find(params[:id])
    if user && user.authenticate(params[:password])
      session.clear
      session[:user_id] = user.id
      flash.notice = 'You have successfully logged in'
      redirect_to '/'
    else
      binding.pry
      flash.alert = 'Username or password was incorrect'
      redirect_to '/'
    end
  end

  # Log out
  def destroy
    session.clear
    redirect_to '/'
  end
end
