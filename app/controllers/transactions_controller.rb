class TransactionsController < ApplicationController
  before_action do
    redirect_to '/' unless current_user
  end

  def index
    @user = current_user
    @other_users = User.all.where.not(id: current_user.id)
  end

  def create
    amount = params[:amount].to_i
    if current_user.can_transfer?(amount)
      receiver = User.find(params[:receiver_id])
      current_user.send_money_to(receiver, amount, params[:note])
      flash.notice = 'Transfer was successful'
    else
      flash.alert = 'Transfer was not successful: amount is too large or negative.'
    end
    redirect_to '/transactions'
  end
end

