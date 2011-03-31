require 'epic/socket_client'
class AdminController < ApplicationController
  def index
  end

  def log_file
    @lines = []
    read_log_file params[:file]
  end

  def view_messages
    @messages = Message.order('created_at')
  end

  def send_message_form
  end
  def send_message
    if params[:user] and params[:message]
      @user = User.find(params[:user][:id])
      jid = @user.name + "@" + APP_CONFIG[:domain]
      epic.send_message jid, params[:message] if @user
      flash[:notice] = "Sent msg to #{@user.name}"
      redirect_to :admin
    end
  end

  private
  def read_log_file file_name
    return unless ['xmpp_service','socket_service'].include? file_name
    file = File.open "#{Rails.root.to_s}/log/#{file_name}.log"
    file.each do |line|
      @lines << line
    end
    @lines.reverse!
  end

end
