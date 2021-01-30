require "stripe"
require 'discordrb'
require 'discordrb/webhooks'
Stripe.api_key             = 'sk_test_HkTSFJCzngOdIFqnGDP9Uked00J29GL5Jq'     # e.g. sk_live_...
StripeEvent.signing_secret = 'whsec_bIeotPWRdGZuyDpdF6ZSpFnafl8SULJQ' # e.g. whsec_...
WEBHOOK_URL = 'https://discord.com/api/webhooks/805098373035327529/3Jybi9zHJEnZ6N2xluGv81vEOxmo_QORX8BcTSerTcWZG_Rni0H5hUSWZLTUllUQpd6p'.freeze

client = Discordrb::Webhooks::Client.new(url: WEBHOOK_URL)
client.execute do |builder|
  builder.content = 'Initialized Discord Bot for Stripe webhooks'
 # builder.add_embed do |embed|
 #   embed.title = 'Embed title'
 #   embed.description = 'Embed description'
 #   embed.timestamp = Time.now
 # end
end

StripeEvent.configure do |events|
  events.subscribe 'invoice.payment_succeeded' do |event|

    # Define subscriber behavior based on the event object
    event.class       #=> Stripe::Event
    event.type        #=> "charge.failed"
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
	UserMailer.with(user: 'nicolascurti75@gmail.com').welcome_email.deliver_now
    #client.execute do |builder|
	#  builder.content = 'Client '+Stripe::Customer.retrieve(event.data.object.customer).email+' has paid 5$/mo'
	#end
  end

  events.all do |event|
    # Handle all event types - logging, etc.
  end
end