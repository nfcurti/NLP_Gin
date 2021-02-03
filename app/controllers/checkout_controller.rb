class CheckoutController < ApplicationController
 	before_action :logged_in_user


	def new
			if logged_in?
				  begin
				    stripe_session = Stripe::Checkout::Session.create(
				      success_url: 'http://ginevar.com?session_id={CHECKOUT_SESSION_ID}',
				      cancel_url: 'http://ginevar.com',
				      payment_method_types: ['card'],
				      mode: 'subscription',
				      customer_email: current_user.email,
				      line_items: [{
				        # For metered billing, do not pass quantity
				        quantity: 1,
				        price: params[:price],
				      }],
				    )
				  rescue => e
				    halt 400,
				        { 'Content-Type' => 'application/json' },
				        { 'error': { message: e.error } }.to_json
				  end

				  @super_id =  stripe_session.id
			else
				redirect_to '/signup'
			end
		end
	
	def destroy
		p current_user
	      cus_id =  Stripe::Customer.list({limit: 3, email:current_user.email}).data[0].id
	      current_user.subid = Stripe::Subscription.list({limit: 3, customer:cus_id}).data[0].id
		Stripe::Subscription.delete(current_user.subid)
        flash[:danger] = "You have successfully unsubscribed, you will no longer be charged."
        flash[:danger] = "You have no longer access."
        flash[:success] = "Hope you come back!"

	end

end
