class SnsOauthController < ApplicationController

  def index
  	@link_sites = {}
    
  	["renren", "neteasemb", "sohuminiblog", "sinaminiblog", "kaixin001", "tianya", "qqmb", "qzone", "taobao"].each do |site|
  		@link_sites[site] = "#{sns_oauth_url}?redirectUrl=#{website_base_url}&site=#{site}"
  	end
  end
end
