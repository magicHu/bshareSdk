class ApiController < ApplicationController
  def index
  	user_follower
  	user_active_follower
  	user_profile
  end

 def user_follower
  	@user_follower_url = "#{website_base_url}/api/user/#{uuid}/follower.json"
  	@user_follower_url << "?site=sinaminiblog&username=xinjun91%2540yahoo.com.cn&password=niu520&cursor=1&count=200"
  end

  def user_active_follower
  	@user_active_follower_url = "#{website_base_url}/api/user/#{uuid}/activeFollower.json"
  	@user_active_follower_url << "?site=sinaminiblog&username=xinjun91%40yahoo.com.cn&password=niu520&count=25"
  end

  def user_profile
  	@user_profile_url = "#{website_base_url}/api/user/#{uuid}/profile.json"
  	@user_profile_url << "?site=sinaminiblog&username=xinjun91%40yahoo.com.cn&password=niu520"
  end

end
