class MobileappsController < ApplicationController
  before_filter :authorize, :except => [:index]
  layout 'jqmapplication'

  def index
  end

  def dialog
    render :layout => "jqmpopup"
  end

  def qrcode
    @action = session[:action_name] 
    session.delete :action_name
  end

  def ringit
  end

  def mapit
  end

  def browserhistory
  end

  protected
  def authorize
    session[:action_name] = action_name unless session[:action_name]
    redirect_to :apps_home unless session[:current_user]
  end

end
