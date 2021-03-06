class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  skip_before_action :verify_authenticity_token
  def show
    @user = User.find(params[:id])
  end

  def new
    if !logged_in?
      @user = User.new
    else
      redirect_to root_url
    end
  end

    def create
    @user = User.new(user_params)
    @user.errors.full_messages
    if @user.save
      log_in @user
    else
      flash.now[:danger] = 'There was a problem'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :sub_id ,:password, :password_confirmation)
  end
end