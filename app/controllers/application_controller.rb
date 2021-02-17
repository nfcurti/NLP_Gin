class ApplicationController < ActionController::Base
  include SessionsHelper
	Stripe.api_key = ENV["STRIPE_APIKEY"]

  private
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
      end
  end

end
