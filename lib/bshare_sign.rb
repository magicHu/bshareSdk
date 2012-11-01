module Bshare
	module Sign
	  def sign(params, secret)
	  	return Digest::MD5.hexdigest(params_to_sign_str(params) + secret)
	  end

	  def params_to_sign_str(params)
	  	params_str = ''
	  	params.sort.each { |key, value|  params_str << key << "=" << value.to_s}
	  	params_str
	  end
	end
end