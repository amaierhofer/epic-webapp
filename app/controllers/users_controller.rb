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

    if @user.available? and @user.register
      session[:current_user] = @user
      #if session[:action_name] 
      #  redirect_to :controller => "mobileapps", :action => session[:action_name]
      #else
      #  redirect_to :welcome_app
      #end
      redirect_to :controller => "mobileapps", :action => "qrcode"
    else
      render :new
    end
  end
  
end
