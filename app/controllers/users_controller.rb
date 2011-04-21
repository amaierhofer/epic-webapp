require 'epic/socket_client'

class UsersController < ApplicationController
  def index
    @users = User.all
    respond_with @users
  end
  
  def show
    find_user
  end
  
  def new
    @user = User.new
  end
  
  
  
end
