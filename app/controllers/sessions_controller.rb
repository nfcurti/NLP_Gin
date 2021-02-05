#sessions_controller.rb
class SessionsController < ApplicationController
  before_action :logged_in_user
  skip_before_action :verify_authenticity_token
  def new
    if logged_in?
      redirect_to root_url
   else 
      render 'new'
   end
  end

  def create
  
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end