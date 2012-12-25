
class BshareButtonController < ApplicationController

	def plus_jifenbao
		@jifenbao_user_id = jifenbao_user_id
		@ts = Time.now.to_i
		@sign = sign({"apvuid" => @jifenbao_user_id, "apts" => @ts}, secret)
	end  

	def plus_local_jifenbao
		@jifenbao_user_id = jifenbao_user_id
		@ts = Time.now.to_i
		@sign = sign({"apvuid" => @jifenbao_user_id, "apts" => @ts}, secret)
	end

	def lite
		@uuid = @@uuid
	end

	def plus
		@uuid = @@uuid
	end

	def lite_local
		@uuid = @@uuid_local
	end

	def plus_local
		@uuid = @@uuid_local
	end

{:params => {:id => 50, 'foo' => 'bar'}}
	def get_user_suggestion
		response = RestClient.get "#{button_base_url}/bshare_user_suggestion", { :params => 
				{'site'=>'sinaminiblog', 'accessToken'=>"2.00kZJdiCdANkCDbcb6711593FTdciD", 'keyword'=>"#{params[:keyword]}"}
		}
		render :text => response.to_str
	end

	private
	def jifengbao_user_id
		'2088002876750515'
	end

end
