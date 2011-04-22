class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_session
  after_filter :add_headers
  layout :decide_layout

  def wants_xmpp?
    APP_CONFIG[:xmpp]
  end

  def add_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end


  protected
    def decide_layout
      return 'jquerymobile' if jqm_enabled?
      return 'design' if design_enabled?
      return 'application'
    end

    def design_enabled?  
      session[:design] ? session[:design] == "1" : false
    end  

    def xmpp_enabled?
      session[:xmpp] ? session[:xmpp] == "1" : true
    end

    def jqm_enabled?  
      session[:jqm] ? session[:jqm] == "1" : true
    end  

    def prepare_session
      session[:jqm] = params[:jqm] if params[:jqm]  
      session[:xmpp] = params[:xmpp] if params[:xmpp]  
      session[:design] = params[:design] if params[:design]  
    end  

    helper_method :epic, :wants_xmpp?, :jqm_enabled? , :xmpp_enabled?, 
      :design_enabled?

    helper_method :user_signed_in?, :current_user

    def current_user
    end

    def user_signed_in?
      false
    end
end

