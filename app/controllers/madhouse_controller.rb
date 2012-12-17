require 'digest/md5'

class MadhouseController < ApplicationController

  @@sites = ["sinaminiblog", "renren", "qqmb"]

  def index
  	userProfile
    user_follow
  end

  def userProfile
    @madhouse_urls = {}

    @@sites.each do |site|  
      params = {"publisherUuid" => uuid, "ts" => Time.now.to_i * 1000, "site" => site, "mhid" => "1234", "callback" => "http://bshare.cn" }
      @madhouse_urls[site] = sign_and_generate_url("#{website_base_url}/api/user/profile", params, secret)
    end
  end

  def user_follow
    @user_follow_urls = {}

    @@sites.each do |site|  
      params = {"site" => site, "mhid" => "1234", "cursor" => 1, "count" => 10 }
      @user_follow_urls[site] = generate_url("#{website_base_url}/api/user/#{uuid}/follower.json", params)
    end
  end

end
