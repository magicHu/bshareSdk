# 纳智捷GPK数据分析

require 'multi_json'
require 'set'

# keywords
# 1. 每款车型对应的cookie总数
def stat_cookie_count_by_car
  # 根据cookie的感兴趣的车型，按照车型作为关键字，分别统计
  keyword_cookiecount = {}  
  load_cookie_keywords.each do |cookie, keywords|
    keywords.each do |keyword|
      count = keyword_cookiecount[keyword] || 0
      keyword_cookiecount[keyword] = count + 1
    end
  end

  puts "1.每款车型对应的cookie总数"
  keyword_cookiecount.sort_by {|k, v| v}.reverse.each do |key, value|
    puts "#{key}\t#{value}"
  end
  puts "\n"
end


# 2. 同时对任意两款车型感兴趣的cookie数量
def stat_cookie_count_by_twocar
  keyword_cookiecount = {}  
  load_cookie_keywords.each do |cookie, keyword_set|
    if keyword_set.size >= 2
      keywords = keyword_set.to_a.sort

      #puts "#{cookie}\t#{keywords}"

      keywords.each_with_index do |keyword1, index|
        remain_keywords = keywords.slice((index+1)...keywords.size)
        if remain_keywords
          remain_keywords.each do |keyword2|
            count = keyword_cookiecount["#{keyword1},#{keyword2}"] || 0
            keyword_cookiecount["#{keyword1},#{keyword2}"] = count + 1
          end
        end
      end

    end
  end

  puts "2. 同时对任意两款车型感兴趣的cookie数量"
  keyword_cookiecount.sort_by {|k, v| v}.reverse.each do |key, value|
    puts "#{key}\t#{value}"
  end
  puts "\n"
end

# categorys
# 3. 每款车型用户的一级interest排名
def sort_firstlevel_interest
  keyword_categorycounts = stat_secondlevel_interest

  keyword_firstlevel_counts = {}
  keyword_categorycounts.each do |keyword, categorycounts|
    categorycounts.each do |categorycount|
      firstlevel_category = categorycount[0][0, 2]
      firstlevel_counts = (keyword_firstlevel_counts[keyword] ||= Hash.new)
      count = firstlevel_counts[firstlevel_category] || 0

      firstlevel_counts[firstlevel_category] = count + categorycount[1]
    end
  end

  puts "3.每款车型用户的一级interest排名"
  keyword_firstlevel_counts.each do |keyword, counts|
    puts "#{keyword}\t#{counts.sort_by {|k, v| v}.reverse}"
  end
  puts "\n"
end

# 4. 每款车型用户的二级interest排名
def sort_secondlevel_interest
  keyword_categorycount = stat_secondlevel_interest
  puts "4.每款车型用户的二级interest排名"
  keyword_categorycount.each do |key, categorycount|
    puts "#{key}\t#{categorycount.sort_by {|k, v| v}.reverse[0, 10]}"
  end
  puts "\n"
end

def stat_secondlevel_interest
  keyword_cookies = load_keyword_cookies
  cookie_categorys = load_cookie_categorys

  keyword_categorycount = {}
  keyword_cookies.each do |keyword, cookies|
    categorycount = (keyword_categorycount[keyword] ||= Hash.new)

    cookies.each do |cookie|
      categorys = cookie_categorys[cookie]
      if categorys
        categorys.each do |category|
          count = categorycount[category] || 0
          categorycount[category] = count + 1
        end
      end
    end
  end
  keyword_categorycount
end


# weibo information
# 5. 每款车型用户的性别统计
def stat_gender
  keyword_gender_count = {}
  keyword_weibo_info do |keyword, weibo_info|
    gender = weibo_info['g']

    if gender
      gender_counts = (keyword_gender_count[keyword] ||= Hash.new)
      gender_counts[gender] = (gender_counts[gender] || 0) + 1
    end
  end

  puts "5. 每款车型用户的性别统计"
  keyword_gender_count.each do |keyword, gender_count|
    puts "#{keyword}\t#{gender_count.sort}"
  end
  puts "\n"
end

# 6. 每款车型用户的年龄统计
def stat_age
  keyword_birthday_count = {}
  keyword_weibo_info do |keyword, weibo_info|
    birthday = weibo_info['by']

    if birthday
      birthday_count = (keyword_birthday_count[keyword] ||= Hash.new)
      birthday_count[birthday] = (birthday_count[birthday] || 0) + 1
    end
  end

  puts "6. 每款车型用户的年龄统计"
  keyword_birthday_count.each do |keyword, birthday_count|
    puts "#{keyword}\t#{birthday_count.sort_by {|k, v| v}.reverse}"
  end
  puts "\n"
end

# 7. 每款车型用户的省份统计
def stat_provice
  keyword_provice_count = {}
  keyword_weibo_info do |keyword, weibo_info|
    provice = weibo_info['p']

    if provice
      provice_count = (keyword_provice_count[keyword] ||= Hash.new)
      provice_count[provice] = (provice_count[provice] || 0) + 1
    end
  end

  puts "7. 每款车型用户的省份统计"
  keyword_provice_count.each do |keyword, provice_count|
    puts "#{keyword}\t#{provice_count.sort_by {|k, v| v}.reverse}"
  end
  puts "\n"
end

# 8. 每款车型用户的城市统计
def stat_city
  keyword_city_count = {}
  keyword_weibo_info do |keyword, weibo_info|
    city = weibo_info['c']

    if city
      city_count = (keyword_city_count[keyword] ||= Hash.new)
      city_count[city] = (city_count[city] || 0) + 1
    end
  end

  puts "8. 每款车型用户的城市统计"
  keyword_city_count.each do |keyword, city_count|
    puts "#{keyword}\t#{city_count.sort_by {|k, v| v}.reverse}"
  end
  puts "\n"
end


# Footprint
# 9. 域名整体排名
def sort_domain
  cookie_footprint = load_cookie_footprint

  domain_counts = {}
  cookie_footprint.each do |cookie, footprint|
    domain = footprint['domain']
    count = (domain_counts[domain] ||= 0)
    domain_counts[domain] = count + 1
  end

  puts "9.域名整体排名"
  domain_counts.sort_by {|k, v| v}.reverse.slice(0, 10).each do |domain_count|
    puts "#{domain_count[0]}\t#{domain_count[1]}"
  end
  puts "\n"
end

# 10. 每款车型的域名排名
def sort_domain_by_car
  cookie_footprint = load_cookie_footprint
  cookie_keywords = load_cookie_keywords

  keyword_domain_counts = {}
  cookie_footprint.each do |cookie, footprint|
    domain = footprint['domain']

    keywords = cookie_keywords[cookie]
    keywords.each do |keyword|
      domain_counts = (keyword_domain_counts[keyword] ||= Hash.new)

      count = domain_counts[domain] || 0
      domain_counts[domain] = count + 1
    end
  end

  puts "10.每款车型的域名排名"
  keyword_domain_counts.each do |keyword, domain_counts|
    puts "#{keyword}\t#{domain_counts.sort_by {|k, v| v}.reverse.slice(0, 10)}"
  end
  puts "\n"
end

private

def load_cookie_weiboinfo
  unless @cookie_info
    cookie_uid = load_cookie_uid
    weibo_infos = load_weibo_infos

    @cookie_info = {}
    cookie_uid.each do |cookie, uid|
      @cookie_info[cookie] = weibo_infos[uid]
    end
  end

  @cookie_info
end


# key: keyword, value: cookie list
def load_keyword_cookies
  unless @keyword_cookies
    cookie_keywords = load_cookie_keywords

    @keyword_cookies = {}
    cookie_keywords.each do |cookie, keywords|
      keywords.each do |keyword|
        cookies = (@keyword_cookies[keyword] ||= Set.new)
        cookies.add(cookie)
      end
    end
  end
  @keyword_cookies
end

# key: coookie, value: category list
def load_cookie_categorys
  unless @cookie_categorys
    cookie_category_info = load_json_file("data/luxgen/cookie_categorys.data", "cid")

    @cookie_categorys = {}
    cookie_category_info.each do |key, value|
      categorys = (@cookie_categorys[key] ||= Set.new)

      value['cat'].split(",").each do |category|
        categorys.add(category)
      end
    end
  end

  @cookie_categorys
end

def load_cookie_keywords
  unless @cookie_keywords
    cookie_keyword_info = load_json_file("data/luxgen/cookie_keywords.data", "cid")

    @cookie_keywords = {}
    cookie_keyword_info.each_pair do |key, value|
      keywords = (@cookie_keywords[key] ||= Set.new)

      value['k'].split(",").each do |category|
        keywords.add(category)
      end
    end
  end

  @cookie_keywords
end

def load_cookie_uid
  unless @cookie_uids
    cookie_keyword_info = load_json_file("data/luxgen/cookie_keywords.data", "cid")

    @cookie_uids = {}
    cookie_keyword_info.each_pair do |key, value|
      uid = value['u']
      if uid
        @cookie_uids[key] = uid
      end
    end
  end

  @cookie_uids
end

def load_cookie_footprint
  unless @cookie_footprint
    @cookie_footprint = load_json_file("data/luxgen/footprint.data", "cid")  
  end
  @cookie_footprint
end

def load_weibo_infos
  unless @weibo_info
    @weibo_info = load_json_file("data/luxgen/weibo_infos.data", "u")
  end
  @weibo_info
end

def load_json_file(file_path, key_name)
  json_map = {}
  File.open(file_path).each_line do |line|
    begin
      json = MultiJson.load(line)
      key = json[key_name]

      json_map[key] = json
    rescue Exception => e
      puts e.message
    end
  end
  json_map
end


def keyword_weibo_info(&block)
  cookie_weiboinfo = load_cookie_weiboinfo
  keyword_cookies = load_keyword_cookies

  keyword_cookies.each do |keyword, cookies| 
    cookies.each do |cookie|
      weibo_info = cookie_weiboinfo[cookie]
      if weibo_info
        yield keyword, weibo_info
      end
    end
  end
end


stat_cookie_count_by_car
stat_cookie_count_by_twocar

sort_firstlevel_interest
sort_secondlevel_interest

stat_gender
stat_age
stat_provice
stat_city

sort_domain
sort_domain_by_car