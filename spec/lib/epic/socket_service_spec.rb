describe Epic::SocketService do

  before do
    @obj = Class.new { include Epic::SocketService }.new
  end

  it "can recieve data" do
    @obj.should respond_to :receive_data
  end

  it "sends message for 'msg>a@b some text'" do
    @obj.should_receive(:send_msg).with('a@b some text')
    @obj.receive_data 'msg>a@b some text'
##    Epic::XMPPService.should_receive(:say).with('a@b', 'some text')
  end

  it "sends message for 'cmd>register a b a'" do
    @obj.should_receive(:exec_ejabberd).with('register a b a')
    @obj.receive_data 'cmd>register a b a'
  end
end
