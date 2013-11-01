require 'httparty'

@access_token = "2.003k6msBdANkCD0d72ec0623dEXb9E"
#uid = "1725593694"

def get_screen_name(uid)
  url = "https://api.weibo.com/2/users/show.json?access_token=#{@access_token}&uid=#{uid}"
  response = HTTParty.get(url)
  respone_body = response.body
  json = MultiJson.load(respone_body)
  json['screen_name']
end

File.open("uids.txt").each_line do |line|
  words = line.split("\t")
  uid = words[0]

  puts get_screen_name(uid)
end