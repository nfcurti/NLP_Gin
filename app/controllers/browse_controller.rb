class BrowseController < ApplicationController
  def home
	@client = Airtable::Client.new("keyWgEI0t7Z6TXkog")
	@table = @client.table("appWlcYj2idOcJ30G", "jobs")
	@records = @table.records(:sort => ["created", :desc], :limit => 10)
  end
end
