require 'rest_client'
class User 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :password
  validates_presence_of :name, :password

  def initialize(hash = {})
    hash.each do |name, value|
      send "#{name}=", value
    end
  end

  def persisted?
    false
  end

  def admin 
    APP_CONFIG[:admin] 
  end

  def available? 
    request {  RestClient.get "#{admin}/users/#{name}"  }
  end



  def register
    request do
      RestClient.post "#{admin}/users", :newusername => name, 
        :newuserpassword => password, :addnewuser => 'Add User'
    end
  end

  protected
  def request
    begin
      yield
    rescue => e
      false
    end
  end


end
