class ApplicationController < ActionController::Base
  protect_from_forgery

  @@base_url = "http://www.bshare.local/bshare_website/"

  def website_base_url
  	@@base_url
  end


  protected
	def sign(params, secret)
		sign_str = params_to_sign_str(params) + secret
		puts sign_str
	  	return Digest::MD5.hexdigest(sign_str)
	  end

	  def params_to_sign_str(params)
	  	params_str = ''
	  	params.sort.each { |key, value|  params_str << key << "=" << value.to_s}
	  	params_str
	  end
end
