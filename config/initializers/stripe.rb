require "stripe"
require 'discordrb'
require 'discordrb/webhooks'
require 'airtable'
@client = Airtable::Client.new("keyWgEI0t7Z6TXkog")
@table = @client.table("appWlcYj2idOcJ30G", "keys")
Stripe.api_key             = 'sk_test_HkTSFJCzngOdIFqnGDP9Uked00J29GL5Jq'     # e.g. sk_live_...
StripeEvent.signing_secret = 'whsec_BITjYLGxHbmJrw78AUiL6JHUddJA2dNr' # e.g. whsec_...
WEBHOOK_URL = 'https://discord.com/api/webhooks/805794250767073290/s8Y-wSojS_HMzfvXEKlYItBJmqJ8Alp-LL_9BOjYfpAwCirNB2SzHCUP5xv8mBXvtYh2'.freeze

client = Discordrb::Webhooks::Client.new(url: WEBHOOK_URL)
client.execute do |builder|
  builder.content = 'Initialized Discord Bot for Stripe webhooks'
  #make_invite(max_age = 0, max_uses = 0, temporary = false, unique = false, reason = nil)

end

StripeEvent.configure do |events|
  events.subscribe 'invoice.paid' do |event|

	    # Define subscriber behavior based on the event object
	    event.class       #=> Stripe::Event
	    event.type        #=> "charge.failed"
	    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
	    @bill = @table.records.first
	    @mail_to_address = Stripe::Customer.retrieve(event.data.object.customer).email
		UserMailer.with(user: @mail_to_address, key: @bill.key).welcome_email.deliver_now
	    
	    client.execute do |builder|
		  builder.content = 'Client '+@mail_to_address+' has paid 5$/mo'
		end
		@table.destroy(@bill.id)
  end

  events.all do |event|
    # Handle all event types - logging, etc.
  end
end