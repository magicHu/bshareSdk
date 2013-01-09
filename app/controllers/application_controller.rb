class ApplicationController < ActionController::Base
	protect_from_forgery

	@@base_website_url = "http://www.bshare.cn"
	@@base_website_local_url = "http://www.bshare.local/bshare_website"

	@@base_one_url = "http://one.bshare.cn"
	@@base_one_local_url = "http://one.bshare.local/bshare_passport"

	@@base_button_url ="http://b.bshare.cn"
	@@base_button_local_url = "http://button.bshare.local/bshare_button"

	@@base_points_url = "http://points.bshare.cn"
	@@base_points_local_url = "http://points.bshare.local/bshare_points"

	@@uuid_local = '5a38b99e-576c-48b3-a383-facf7fc86505'
	@@secret_local = '7ec6e6a0-d15e-42d7-9d0a-d0ca2b246ebb'

	# test server
	@@uuid = 'e2272e96-311e-493a-ac48-4f4d31e58af9'
	@@secret = '3037299e-3932-45f9-8a8c-cc93e249c117'

	#@@uuid = 'ca720443-9e43-4408-9cee-b1b0dca57ab1'
	#@@secret = '2c63b599-0a1e-4649-a01a-d3e7ba8185e7'

	@@sns_oauth_url = "http://one.bshare.cn/oauth/authentication"
	@@sns_oauth_local_url = "http://one.bshare.local/bshare_passport/oauth/authentication"

  @@user_name = {}
  @@password = { 'kaixin001' => 'niuniu520' }

  @@bshare_user = "publisher@magic.com"
  @@bshare_password = "test"

	protected
		def sign(params)
			sign(params, secret)
		end

		def sign(params, secret)
			@sign_str = params_to_sign_str(params) + secret
	  	return Digest::MD5.hexdigest(@sign_str)
		end

		def params_to_sign_str(params)
		  	params_str = ''
		  	params.sort.each { |key, value|  params_str << key << "=" << value.to_s}
		  	params_str
		end

		def uuid
			if is_local
				@@uuid_local
			else
				@@uuid
			end
		end

		def secret
			if is_local
				@@secret_local
			else
				@@secret
			end
		end

		def website_base_url
			if is_local
				@@base_website_local_url
			else 
				@@base_website_url
			end
		end

		def one_base_url
			if is_local
				@@base_one_local_url
			else 
				@@base_one_url
			end
		end

		def points_base_url
			if is_local
				@@base_points_local_url
			else 
				@@base_points_url
			end
		end

		def button_base_url
			if is_local
				@@base_button_local_url
			else
				@@base_button_url
			end
		end

		def sns_oauth_url
			if is_local
				@@sns_oauth_local_url
			else 
				@@sns_oauth_url
			end
		end

		def is_local
			params[:server] == 'local'
		end

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

	  def username
	  	@@bshare_user
	  end

	  def password
	  	@@bshare_password
	  end

end
