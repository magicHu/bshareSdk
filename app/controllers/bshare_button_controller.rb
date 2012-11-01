
class BshareButtonController < ApplicationController

	def plus_local_jifenbao
		@jifenbao_user_id = '2088002876750515'
		@ts = Time.now.to_i
		@sign = sign({"apvuid" => @jifenbao_user_id, "apts" => @ts}, @@secret)
	end  

end
