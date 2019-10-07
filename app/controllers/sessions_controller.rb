class SessionsController < ApplicationController

  # Log in menu
  def new
    if current_user
      redirect_to '/transactions'
    else
      @users = User.all
    end
  end

  # Log in
  def create
    user = User.find(params[:id])
    if user && user.authenticate(params[:password])
      session.clear
      session[:user_id] = user.id
      flash.notice = 'You have successfully logged in'
      redirect_to '/transactions'
    else
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
