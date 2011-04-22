require 'spec_helper'
require 'webmock/rspec'

describe User do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  context "attributes" do
    its(:name) { should be_nil }
    its(:password) { should be_nil }
  end

  context "constructor accepts hash" do
    subject { User.new(:name => "foo", :password => "bar") }
    its(:name) { should == "foo" }
    its(:password) { should == "bar" }
  end

  pending "active model validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :password }
  end

  context "#available?" do
    before do 
      @user = User.new  :name => "foo"
      @url = APP_CONFIG[:admin] + "/user/foo"
      @body = IO.readlines(File.dirname(__FILE__) + "/user_not_found.html").join('')
    end


    it "returns false and populates errors" do
      stub_request(:get, @url).to_return(:body => @body)
      @user.available?.should == true
      @user.errors.should be_empty
    end

    it "returns true and empty errors" do
      @body.gsub! 'Not Found', ''
      stub_request(:get, @url).to_return(:body => @body)
      @user.available?.should == false
      @user.errors.should_not be_empty
    end
  end

  context "#register" do
    before do 
      @user = User.new :name => "foo", :password => "bar"
      @url = APP_CONFIG[:admin] + "/users"
    end

    it "returns true for 200" do
      stub_request(:post, @url)
      @user.register.should == true
      WebMock.should have_requested(:post, @url)
    end

    it "returns false for not 200" do
      stub_request(:post, @url).to_return(:status => 500)
      @user.register.should == false

      body = "newusername=foo&newuserpassword=bar"
      body += "&addnewuser=Add%20User"
      WebMock.should have_requested(:post, @url).with(:body => body)
    end
  end

  context ".authenticate" do
    before do 
      @url = APP_CONFIG[:admin] + "/user/admin"
      @body = IO.readlines(File.dirname(__FILE__) + "/user.html").join('')
    end

    it "returns true for matching password" do
      stub_request(:get, @url).to_return(:status => 200, :body => @body)
      User.authenticate('admin','admin').should == true
      WebMock.should have_requested(:get, @url)
    end

    it "returns false for wrong password" do
      stub_request(:get, @url).to_return(:status => 200, :body => @body)
      User.authenticate('admin','lala').should == false
      WebMock.should have_requested(:get, @url)
    end
  end

end
