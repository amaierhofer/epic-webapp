require 'epic/socket_client'
class WelcomeController < ApplicationController

  layout 'simple'

  def app
    render :layout => 'application'
  end
  ## jqm == jquery mobile

  def xmpp
    render :layout => 'jasmine'
  end

  private
  def alive?
    obj = Class.new { include Epic::SocketClient }.new
    obj.alive?
  end

end
