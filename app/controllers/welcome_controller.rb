class WelcomeController < ApplicationController
#  before_filter :reset_jqm, :only => :index

  def index
    session[:jqm] = "0"
  end

  def design
    render :index, :layout => 'design'
  end

  def xmpp
    render :layout => 'jasmine'
  end

end

