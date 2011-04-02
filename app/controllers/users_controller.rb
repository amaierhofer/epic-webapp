require 'epic/socket_client'

class UsersController < ApplicationController
  respond_to :html, :xml, :json
  protect_from_forgery :except => [:create, :destroy]
  before_filter :authenticate_user!, :except => [:index, :create]

  def options
    render :layout => 'jqmpopup' if request.get?
  end

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
  
  def create
    @user = User.new(params[:user])
    flash[:notice] = "Successfully created user." if user.save
    respond_with @user
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user
  end

  private 
    def find_user
      if params[:id]
        @user = User.find(params[:id])
      else
        @user = current_user
      end
    end
    ## see above, query for user by name if necessary
    def read_bookmarklet
      file = "#{Rails.root.to_s}/public/javascripts/bookmarklet.js"
      lines= []
      File.open(file) do |f|
        lines = f.readlines
      end
      content = lines.join ' '
      content.gsub!('$jid',"#{@user.username}@#{APP_CONFIG[:domain]}")
      content.gsub('$url',APP_CONFIG[:url])
    end
end
