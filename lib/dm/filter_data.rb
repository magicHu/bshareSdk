# encoding: UTF-8

File.open("data/keyword_category_counts.new") do |file|
  File.open("data/keyword_category_counts").each_line do |line|
    keyword_count = line.split("\t")

    if keyword_count[0]
    file.puts line
  end
end