require 'epic/socket_client'

class UsersController < ApplicationController
  
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.available? and @user.register
      redirect_to :welcome_app
    else
      render :new
    end
  end
  
end
