class MobileappsController < ApplicationController
  before_filter :authorize, :except => [:index]
  layout 'jqmapplication'

  def index
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
    redirect_to :welcome_app unless session[:current_user]
  end

end
