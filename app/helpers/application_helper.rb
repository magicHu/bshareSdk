module ApplicationHelper

  def server
    session[:server] ||= 'local'
  end
end
