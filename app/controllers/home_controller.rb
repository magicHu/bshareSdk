class HomeController < ApplicationController
  def index
  end

  def change_server
    server = params[:server]
    session[:server] = server if server

    redirect_to root_url
  end
end
