class WelcomeController < ApplicationController
#  before_filter :reset_jqm, :only => :index
  def index
    session[:jqm] = "0"
    if design_enabled?
      render :showcase
    end
  end

  def design
    render :index, :layout => 'design'
  end


end

