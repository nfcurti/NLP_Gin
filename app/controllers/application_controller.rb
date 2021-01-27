class ApplicationController < ActionController::Base
  include SessionsHelper
	Stripe.api_key = 'sk_test_HkTSFJCzngOdIFqnGDP9Uked00J29GL5Jq'

  private
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
      end
  end

end
