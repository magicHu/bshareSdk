
require 'multi_json'

def init_user_keywords
  user_keywords = {}

  File.open("data/suv_2013-09-25.data").each_line do |line|
    json = MultiJson.load(line)

    user_keywords[json['cid']] = json['k']
  end
  user_keywords
end

def init_user_categorys
  user_categorys = {}

  File.open("data/user_info.data").each_line do |line|
    infos = line.split("\t")

    if (infos.size >= 2)
      user_categorys[infos[0]] = infos[1]
    end
  end
  user_categorys
end

def stat_category_count(user_category_count, category_str)
  categorys = category_str.split(",")

  categorys.each do |category|
    begin
      count = user_category_count[category.to_i] || 0
      user_category_count[category.to_i] = count + 1
    rescue Exception => e
      
    end

  end
end

@car_keywords = ["纳智捷 大7 SUV", "大众 途观", "本田 CR-V", "丰田 RAV4"]
@user_category_counts = Array.new(@car_keywords.size, {})
  
user_categorys = init_user_categorys
user_keywords = init_user_keywords

user_categorys.each do |cid, category|
  keywords = user_keywords[cid]

  @car_keywords.each_with_index do |car, index|
    if (keywords.include? car)
      user_category_count = @user_category_counts[index]

      stat_category_count(user_category_count, category)
    end
  end
end

@user_category_counts.each_with_index do |user_category_count, index|
  puts @car_keywords[index]
  user_category_count.sort_by {|k,v| v}.reverse[0, 5].each do |key, value|
    puts "#{key}=#{value}"
  end
end
