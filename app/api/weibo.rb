
require 'weibo_2'

WeiboOAuth2::Config.api_key = ""
WeiboOAuth2::Config.api_secret = ""
WeiboOAuth2::Config.redirect_uri = ""

client = WeiboOAuth2::Client.new
puts client.access_token
client.access_token = '2.003k6msBdANkCD0d72ec0623dEXb9E'
puts client
puts client.users
puts client.users.show({'access_token' => '2.003k6msBdANkCD0d72ec0623dEXb9E', 'uid' => '1725593694'})
