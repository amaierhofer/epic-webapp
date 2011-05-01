class SessionsController < ApplicationController
  layout 'jqmapplication'

  def create
    name, password = params[:user][:name], params[:user][:password]

    if User.authenticate(name, password)
      session[:current_user] = User.new(:name => name, :password => password)
      if session[:action_name] 
        redirect_to :controller => "mobileapps", :action => session[:action_name]
      else
        redirect_to :welcome_app
      end
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
