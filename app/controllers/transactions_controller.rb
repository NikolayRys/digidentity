class TransactionsController < ApplicationController
  before_action do
    redirect_to '/' unless current_user
  end

  def index
    @user = current_user
  end

  def create

  end
end

