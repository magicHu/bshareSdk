class ApplicationController < ActionController::Base
  protect_from_forgery

  @@base_url = "http://www.bshare.cn/"
  @@base_local_url = "http://www.bshare.local/bshare_website/"

  @@uuid_local = '5a38b99e-576c-48b3-a383-facf7fc86505'
  @@secret_local = '7ec6e6a0-d15e-42d7-9d0a-d0ca2b246ebb'

	@@uuid = 'e2272e96-311e-493a-ac48-4f4d31e58af9'
	@@secret = '3037299e-3932-45f9-8a8c-cc93e249c117'


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
