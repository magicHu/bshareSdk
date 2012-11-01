require 'digest/md5'

class MadhouseController < ApplicationController

  @@sites = ["sinaminiblog", "renren", "qqmb"]

  def index
  	userProfile

    user_follow
  end

  def userProfile
  	api_url = "api/user/profile"

    @madhouse_urls = {}
    @madhouse_local_urls = {}
    @@sites.each do |site|  
      params = {"publisherUuid" => @@uuid, "ts" => Time.now.to_i * 1000, "site" => site, "mhid" => "1234", "callback" => "http://bshare.cn" }
      @madhouse_urls[site] = sign_and_generate_url(@@base_url + api_url, params, @@secret)

      params_local = {"publisherUuid" => @@uuid_local, "ts" => Time.now.to_i * 1000, "site" => site, "mhid" => "1234", "callback" => "http://bshare.cn" }
      @madhouse_local_urls[site] = sign_and_generate_url(@@base_local_url + api_url, params_local, @@secret_local)
    end
  end

  def user_follow
    api_url = ""
    api_url << "api/user/" << @@uuid << "/follower.json"

    @user_follow_urls = {}
    @user_follow_local_urls = {}
    @@sites.each do |site|  
      params = {"site" => site, "mhid" => "1234", "cursor" => 1, "count" => 10 }
      @user_follow_urls[site] = generate_url(@@base_url + api_url, params)
      
      @user_follow_local_urls[site] = generate_url(@@base_local_url + api_url, params)
    end
  end

  private
  def sign_and_generate_url(base_url, params, secret)
    params["sig"] = sign(params, secret)
    return generate_url(base_url, params)
  end

  def generate_url(base_url, params)
  	URI.escape(base_url + "?" + params_to_url_str(params))
  end

  def params_to_url_str(params)
  	params_str = ''
  	params.each { |key, value|  params_str << key << "=" << URI.escape(value.to_s) << "&"}
  	params_str.slice(0, params_str.length - 1)
  end

end
