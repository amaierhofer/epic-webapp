class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare
  after_filter :add_headers

  def wants_xmpp?
    APP_CONFIG[:xmpp]
  end

  def add_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  def is_ajax_request?
    request.headers['x-requested-with'] == 'XMLHttpRequest'
  end

  def after_sign_in_path_for(resource_or_scope)
#    return "/##{root_path}profile" if root_path == "/"
#    return "#{root_path}##{root_path}profile"
     return current_user
  end


  protected
    ## also talks to epic, use errors of user to communicate problems?
    def epic
      Class.new { include Epic::SocketClient }.new  private  
    end

    def xmpp_enabled?
      session[:xmpp] ? session[:xmpp] == "1" : true
    end

    def jqm_enabled?  
      session[:jqm] ? session[:jqm] == "1" : true
    end  

    def prepare
      session[:jqm] = params[:jqm] if params[:jqm]  
      session[:xmpp] = params[:xmpp] if params[:xmpp]  
    end  

    helper_method :epic, :wants_xmpp?, :jqm_enabled? , :xmpp_enabled?
end

