require 'multi_json'

@file = "data/suv_2013-09-25.data"
@key_car = "大众 途观"
@other_car = ["福特 翼虎", "北京现代 ix35", "丰田 RAV4", "本田 CR-V", "东风标致 3008", "大众 帕萨特", "大众 途锐"]
@counts = [0, 0, 0, 0, 0, 0, 0]
@onlyKey = 0

File.open(@file).each_line do |line|
  cid_keywords = MultiJson.load(line)
  
  keywords = cid_keywords['k']
  if (keywords == @key_car) 
    @onlyKey += 1
  elsif (keywords.include? @key_car)
    @other_car.each_with_index do |car, index|
      if (keywords.include? car)
        @counts[index] = @counts[index] + 1
      end
    end
  end
end

puts "#{@key_car} = #{@onlyKey}"
puts "==========="
@other_car.each_with_index do |car, index|
  puts "#{car}=#{@counts[index]}"
end

