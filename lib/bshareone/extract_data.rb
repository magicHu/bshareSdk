# encoding: UTF-8
require 'rubygems'
require 'roo'

OUT_PUT_FILE = "migo.txt"

def extract_data_from_excel(file_path)
  excel = Roo::Excel.new(file_path)
  excel.default_sheet = excel.sheets.first

  File.open(OUT_PUT_FILE, "a") do |file|
    2.upto(excel.last_row) do |line|
      content = excel.cell(line, 'B')
      time    = excel.cell(line, 'C')
      uid     = excel.cell(line, 'D')
      type    = 0
      if ('True' == excel.cell(line, 'H')) 
        type = 1 
      end

      if content
        file.puts "{\"u\":\"#{uid}\",\"tweet\":\"#{content}\",\"type\":\"#{type}\",\"t\":\"#{time}\"}"
      end
    end
  end
end

Dir["data/*微博列表*.xls"].each do |file_name|
  extract_data_from_excel(file_name)
end
