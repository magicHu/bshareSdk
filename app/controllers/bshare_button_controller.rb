
class BshareButtonController < ApplicationController

	@@secret = '7ec6e6a0-d15e-42d7-9d0a-d0ca2b246ebb'

	def plus_local_jifenbao
		@jifenbao_user_id = '2088002876750515'
		@ts = Time.now.to_i

		params = {"apvuid" => @jifenbao_user_id, "apts" => @ts}
		@sign = sign(params, @@secret)

		puts @sign
	end  

end
