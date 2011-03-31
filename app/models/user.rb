require 'epic/socket_client'
class User < ActiveRecord::Base
  include Epic::SocketClient


  ## race condition
  # in case of pw mismatch, the user is still created in epic 
  # we need something
  #
  before_validation(:set_email_to_username, :on => :create)
#  before_validation(:check_epic_is_alive, :on => :create)

  after_create  :must_register_with_epic
  before_destroy :remove_from_epic

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username

#  validates_length_of :name, :in => 1..2
#  validates_length_of :name, :maximum => 5
  private

  def set_email_to_username
    self.email = self.username
  end

  def check_epic_is_alive
    return unless APP_CONFIG[:xmpp]
    errors.add_to_base('Epic service not running') unless alive?
  end

  def must_register_with_epic
    return unless APP_CONFIG[:xmpp]
    errors.add_to_base('Epic registration failed') unless register(username, password)
  end

  def remove_from_epic
    return unless APP_CONFIG[:xmpp]
    unregister(username)
  end

end
