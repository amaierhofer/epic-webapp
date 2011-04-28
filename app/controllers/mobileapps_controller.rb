class MobileappsController < ApplicationController
  before_filter :authorize, :except => [:index]
  layout 'jquerymobile'

  def index
  end

  def qrcode
  end

  def ringit
  end

  def mapit
  end

  def browserhistory
  end

  protected
  def authorize
    session[:action_name] = action_name
    redirect_to :welcome_app unless session[:current_user]
  end

end
