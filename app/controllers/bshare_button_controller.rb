
class BshareButtonController < ApplicationController

	def plus_local_jifenbao
		@uuid = "5a38b99e-576c-48b3-a383-facf7fc86505"

		@jifenbao_user_id = '2088002876750515'
		@ts = Time.now.to_i
		@sign = sign({"apvuid" => @jifenbao_user_id, "apts" => @ts}, @@secret_local)
	end  

	def plus_jifenbao
		@uuid = "5a38b99e-576c-48b3-a383-facf7fc86505"
		
		@jifenbao_user_id = '2088002876750515'
		@ts = Time.now.to_i
		@sign = sign({"apvuid" => @jifenbao_user_id, "apts" => @ts}, @@secret)
	end  

	def lite
		@@uuid = 'e2272e96-311e-493a-ac48-4f4d31e58af9'
	end

	def plus
		@@uuid = 'e2272e96-311e-493a-ac48-4f4d31e58af9'
	end

	def plus_local
		@uuid = "5a38b99e-576c-48b3-a383-facf7fc86505"
	end

	def lite_local
		  @@uuid = '5a38b99e-576c-48b3-a383-facf7fc86505'
	end

end
