class MessagesController < ApplicationController
  respond_to :html

  def new
    @user = find_user
  end

  def index
    @messages = Message.order('created_at')
    respond_with @messages
  end

  def create
    @user = find_user
    @message = @user.messages.build(params[:message])
    if @message.save
      flash[:notice] = "Message created successfully."
    end

    redirect_to @user
#    if is_ajax_request?
#      redirect_to :user_root
#    else
#      respond_with @message
#    end
  end

  def show
    @message = Message.find(params[:id])
  end

  private
  ## later we want to send messages to different users, admin powers?
  def find_user
    current_user
  end
end
