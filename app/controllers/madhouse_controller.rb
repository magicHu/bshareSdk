class MadhouseController < ApplicationController

  def index
  end

  def userProfile
  	@url = "http://www.bshare.local/bshare_website/" + "api/user/profile"

  	@params = {}
  	
  end


  def generate_url(base_url, params)

  end


end
