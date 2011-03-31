require 'epic/socket_client'
class WelcomeController < ApplicationController
  def index
    render :layout => 'simple' 
  end

  ## jqm == jquery mobile
  def jqm
    render :layout => 'page'
  end

  def xmpp
    render :layout => 'jasmine'
  end

  private
  def alive?
    obj = Class.new { include Epic::SocketClient }.new
    obj.alive?
  end

end
