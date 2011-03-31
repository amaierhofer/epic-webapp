class HomeController < ApplicationController
  def index
    flash[:notice] =  'You come to the right place'
  end

  def msg
    status = send_msg "admin@#{APP_CONFIG[:domain]}", "msg from rails"
    render :nothing => true, :status => status
  end

  def urls
    jid = params[:jid]
    url = params[:url]
    if jid and url
      send_msg jid, url
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 500
    end
  end

end
