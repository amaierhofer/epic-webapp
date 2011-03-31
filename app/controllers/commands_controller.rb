class CommandsController < ApplicationController
  def index
    @commands = Command.all
  end
  
  def show
    @command = Command.find(params[:id])
  end
  
  def new
    @command = Command.new
  end
  
  def create
    @command = Command.new(params[:command])
    @command.user_id = params[:user_id]
    if @command.save
      flash[:notice] = "Successfully created command."
      redirect_to url_for(@command.user)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @command = Command.find(params[:id])
  end
  
  def update
    @command = Command.find(params[:id])
    if @command.update_attributes(params[:command])
      flash[:notice] = "Successfully updated command."
      redirect_to @command
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @command = Command.find(params[:id])
    @command.destroy
    flash[:notice] = "Successfully destroyed command."
    redirect_to commands_url
  end
end
