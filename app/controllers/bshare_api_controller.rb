require 'api'

class BshareApiController < ApplicationController

  @@platforms = ["sinaminiblog", "sohuminiblog", "kaixin001", "renren"]

  #include Bshare::API

  def index
    url_methods = self.class.instance_methods(false).select do |method_name|
      method_name.to_s.end_with?("_url")
    end

    url_methods.each do |method|
      self.send(method)
    end
  end

  def send_http_request
    begin
      response = RestClient.get params[:rquest_url]
      render :text => "HTTP #{response.code} #{response}"
    rescue Exception => e
      render :text => "HTTP #{e.response.code} #{e.response}"
    end
  end


  def user_active_follower_url
      # user active follow
      @user_active_follower_urls = {} 
      @@platforms.each do |site|
        @user_active_follower_urls[site] = generate_url("#{api_base_url}/user/#{uuid}/activeFollower.json", 
        {"site" => site, "username" => sns_user_name(site), "password" => sns_password(site)})
      end
    end

    def user_follower_url
      # user follower
      @user_follower_urls = {}
      @@platforms.each do |site|
        @user_follower_urls[site] = generate_url("#{api_base_url}/user/#{uuid}/follower.json", 
          {"site" => site, "username" => sns_user_name(site), "password" => sns_password(site), "cursor" => 1, "count" => 200 })
      end
    end

    def user_follow_url
      # follow user
      @user_follow_urls = {}
      @@platforms.each do |site|
        @user_follow_urls[site] = generate_url("#{api_base_url}/user/#{uuid}/follow.json", 
          {"site" => site, "username" => sns_user_name(site), "password" => sns_password(site)})
      end
    end

    def user_profile_url
      # user profile
      site = "sinaminiblog"
      @user_profile_url = generate_url("#{api_base_url}/user/#{uuid}/profile.json", 
         {"site" => site, "username" => sns_user_name(site), "password" => sns_password(site)})
    end

    def black_list_url
      # todo magic
    end

    def page_stat_url
      @page_data_url = "#{api_base_url}/analytics/pageData.json"
      @uuid_page_stat_url = "#{api_base_url}/analytics/#{uuid}/page.json"
      @reg_uuid_url = "analytics/reguuid.json"
    end

    def report_url
      @report_url = {}
      @report_v2_url = {}
      ["platform", "user"].each do |type|
        @report_url[type] = "#{api_base_url}/analytics/#{uuid}/#{type}_query.json"

        params = add_uuid_secret_ts()
        @report_v2_url[type] = generate_url("#{api_base_url}/analytics/#{type}_query.json", params)
      end
    end

    def set_app_secret_url
      params = {"site" => "sinaminiblog", "appkey" => "testappkey", "appsecret" => "testappsecret"}
      params = add_uuid_secret_ts(params)
      @uuid_app_secret_set = generate_url("#{api_base_url}/publisher/setapp.json", params)
    end

    def hot_product_url
      @hot_product_url = "#{api_base_url}/ec/feeds.json?uuid=#{uuid}"
    end

    def feeds_url
      @feeds = {}
      ['trending', 'shares'].each do |type|
        @feeds[type] = "#{api_base_url}/feeds/#{type}.json"
      end
    end

    def share_v2_url
      @user_share_v2_urls = {}
      @@platforms.each do |site|
        @user_share_v2_urls[site] = share_v2_url(site)
      end
    end

    def user_share_v2_invalid_user_url
      @invalid_user_share_v2_urls = {}
      @@platforms.each do |site|
        @invalid_user_share_v2_urls[site] = invalid_user_share_v2_url(site)
      end
    end

    private
    def share_v2_url(site)
      @user_share_v2_url = "#{api_base_url}/share/share.json"

      params = {"site" => site, "username" => user_name(site), "password" => password(site),
        "url" => "http://www.bshare.cn", "title" => "testshareapiv2", "summary" => "aaaa#{Time.now.to_i}"}

      params = add_uuid_secret_ts(params)
      return generate_url(@user_share_v2_url, params)
    end

    def invalid_user_share_v2_url(site)
      @user_share_v2_url = "#{api_base_url}/share/share.json"

      params = {"site" => site, "username" => "invalid_user", "password" => "invalid_pwd",
        "url" => "http://www.bshare.cn", "title" => "testshareapiv2", "summary" => "aaaa#{Time.now.to_i}"}

      params = add_uuid_secret_ts(params)
      return generate_url(@user_share_v2_url, params)
    end

end
