class AlipayController < ApplicationController
  def index
  	@alipay_login_url = "#{one_base_url}/alipayQuickLogin/login"
  end
end
