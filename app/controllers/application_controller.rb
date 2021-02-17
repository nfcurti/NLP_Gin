class ApplicationController < ActionController::Base
  include SessionsHelper
	#Stripe.api_key = ENV["STRIPE_APIKEY"]
Stripe.api_key = "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"

  private
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
      end
  end

end
