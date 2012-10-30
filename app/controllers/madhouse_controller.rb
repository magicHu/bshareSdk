class MadhouseController < ApplicationController

  def index
  end

  def userProfile
  	@url = "http://www.bshare.local/bshare_website/" + "api/user/profile"

  	@params = {}
  	@params["publisherUuid"] = "1234-5678"
  	@params["ts"] = Time.now

  	@secret = "9999"
  	@params["sig"] = sign(@params, @secret)
  	
  end

  def sign(params, secret)
  	""
  end


  def generate_url(base_url, params)

  end

  def toStr(params)

  end


end
