
require 'multi_json'

path = "data/json.txt"

File.open(path).each_line do |line|
  json = MultiJson.load(line)
  puts "#{json['p']} #{json['c']} #{json['l']}"
end