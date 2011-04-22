require 'rest_client'
require 'open-uri'
gem 'hpricot'

class User 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  #as we use the username in the url
  #we should limit what is allowed
  #e.g. no funky chars just alpha numeric
  #and best not too long

  attr_accessor :name, :password
  validates_presence_of :name, :password

  def self.url 
    APP_CONFIG[:admin] 
  end

  def self.authenticate(name,pw)
    success = false
    url = User.url.gsub /(\w+:\w+)@/, ''
    user, password = $1.split(":")
    open("#{url}/users/#{name}", :http_basic_authentication => [user,password]) do |f| 

      pw_elem = Hpricot(f.read).at "//input[@type='password']"
      pw_value = pw_elem.attributes['value']
      success = true if pw_value == pw
    end
    success
  end


  def initialize(hash = {})
    hash.each do |name, value|
      send "#{name}=", value
    end
  end

  def persisted?
    false
  end

  def available? 
    available = ! User.request { RestClient.get "#{User.url}/users/#{name}"  }
    errors.add :name, "Username not available" unless available
    available
  end

  def register
    registered = User.request do
      RestClient.post "#{User.url}/users", :newusername => name, 
        :newuserpassword => password, :addnewuser => 'Add User'
    end
    errors.add :name, "Username could not be registered" unless registered
    registered
  end

  protected
  def self.request
    success = true
    begin
      yield
    rescue => e
      success = false
    end
    success 
  end
end
