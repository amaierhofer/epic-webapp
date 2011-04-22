require 'rest_client'
require 'open-uri'
require 'hpricot'

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
    req = User.inspect(name)
    req[:pw] and req[:pw].attributes['value'] == pw ? true : false
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
    nf = User.inspect(name)[:nf]
    return true if nf.nil? or nf.inner_html == "Not Found"
    errors.add :name, "not available" 
    false
  end

  def register
    registered = User.request do
      RestClient.post "#{User.url}/users", :newusername => name, 
        :newuserpassword => password, :addnewuser => 'Add User'
    end
    errors.add :name, "could not be registered" unless registered
    registered
  end

  protected
  def self.inspect(username)
    hash = {}
    url = User.url.gsub /(\w+:\w+)@/, ''
    user, password = $1.split(":")
    open("#{url}/user/#{username}", :http_basic_authentication => [user,password]) do |f| 
      doc =  Hpricot(f.read)
      hash[:nf] = doc.at "#content h1"
      hash[:pw] = doc.at "//input[@type='password']"
    end
    hash
  end
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
