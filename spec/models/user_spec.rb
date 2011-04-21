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
      @url = APP_CONFIG[:admin] + "/users/foo"
    end

    it "issues a get to admin/user" do
      stub_request(:get, @url)
      @user.available?
      WebMock.should have_requested(:get, @url)
    end

    it "returns false for 200" do
      stub_request(:get, @url).to_return(:status => 200)
      @user.available? == false
    end

    it "returns true for 404" do
      stub_request(:get, @url).to_return(:status => 404)
      @user.available? == true
    end
  end

  context "#register" do
    before do 
      @user = User.new :name => "foo", :password => "bar"
      @url = APP_CONFIG[:admin] + "/users"
    end

    it "returns true for 200" do
      stub_request(:get, @url)
      @user.register == true
      WebMock.should have_requested(:post, @url)
    end

    it "returns false for not 200" do
      stub_request(:get, @url).to_return(:status => 500)
      @user.register == false

      body = "newusername=foo&newuserpassword=bar"
      body += "&addnewuser=Add%20User"
      WebMock.should have_requested(:post, @url).with(:body => body)
    end
  end

end
