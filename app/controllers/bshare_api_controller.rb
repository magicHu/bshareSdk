class BshareApiController < ApplicationController
  def index
  	user_follower
  	user_active_follower
  	user_profile
    user_share_v2_url
  end

 def user_follower
  	@user_follower_url = "#{api_base_url}/user/#{uuid}/follower.json"
  	@user_follower_url << "?site=sinaminiblog&username=xinjun91%2540yahoo.com.cn&password=niu520&cursor=1&count=200"
  end

  def user_active_follower
  	@user_active_follower_url = "#{api_base_url}/user/#{uuid}/activeFollower.json"
  	@user_active_follower_url << "?site=sinaminiblog&username=xinjun91%40yahoo.com.cn&password=niu520&count=25"
  end

  def user_profile
  	@user_profile_url = "#{api_base_url}/user/#{uuid}/profile.json"
  	@user_profile_url << "?site=sinaminiblog&username=xinjun91%40yahoo.com.cn&password=niu520"
  end

  def user_share_v2_url

    @user_share_v2_urls = {}
    ["sohuminiblog", "kaixin001"].each do |site|
      @user_share_v2_urls[site] = share_v2_url(site)
    end
    @user_share_v2_urls
  end


  private
  def api_base_url
    "#{website_base_url}/api"
  end

  def share_v2_url(site)
    @user_share_v2_url = "#{api_base_url}/share/share.json"

    params = { 'publisherUuid' => uuid, "ts" => Time.now.to_i * 1000, "site" => site, "username" => user_name(site), "password" => password(site), 
      "url" => "http://www.bshare.cn", "title" => "testshareapiv2", "summary" => "aaaa#{Time.now.to_i}"} 

    params["sig"] = sign(params, secret)
    return generate_url(@user_share_v2_url, params)
  end

  def user_name(site)
    @@user_name[site] || "sanford091@qq.com"
  end

  def password(site)
    @@password[site] || "niu520"
  end
end
