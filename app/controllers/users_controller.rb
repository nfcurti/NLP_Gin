class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
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
      p "users"
      p User.all
      flash.now[:danger] = 'There was a problem'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end