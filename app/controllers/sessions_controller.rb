class SessionsController < ApplicationController

  def create
    name, password = params[:user][:name], params[:user][:password]

    if User.authenticate(name, password)
      session[:current_user] = User.new(:name => name, :password => password)
      redirect_to :welcome_app
    else 
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end


  def new
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => "You have been logged out!"
  end

end
