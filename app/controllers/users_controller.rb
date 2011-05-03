class UsersController < ApplicationController
  layout 'jqmapplication'
  
  def new
    @user = User.new
  end
  def checkname
    @user = User.new(params[:user])
    begin 
      render :json => { available: @user.available? }
    rescue
      render :json => { available:  false }
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.valid? and @user.available? and @user.register
      session[:current_user] = @user
      redirect_to :controller => "mobileapps", :action => "qrcode"
    else
      render :new
    end
  end
  
end
