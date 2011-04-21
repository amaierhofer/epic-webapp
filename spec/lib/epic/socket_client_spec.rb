require 'webmock/rspec'
describe Epic::SocketClient do

  before do
    @obj = Class.new { include Epic::SocketClient }.new
  end

  it "uses admin from config" do
    @obj.admin.should eql APP_CONFIG[:admin]
  end

  it "registers via http" do
    url = APP_CONFIG[:admin] + "/users"
    stub_request(:post, url)
    @obj.register "andi", "andi"
    body = "newusername=andi&newuserpassword=andi&addnewuser=Add%20User"
    WebMock.should have_requested(:post, url).with(:body => body)
  end

  it "registers via http" do
    url = APP_CONFIG[:admin] + "/users"
    stub_request(:post, url)
    @obj.register "andi", "andi"
    body = "newusername=andi&newuserpassword=andi&addnewuser=Add%20User"
    WebMock.should have_requested(:post, url).with(:body => body)
  end

end
