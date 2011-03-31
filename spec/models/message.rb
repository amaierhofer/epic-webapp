
require 'spec_helper'
describe Message do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end
  it "support Iq, Mesasge and Epic categories" do
    #Message.categories.should == %w[Iq Message Epic]
    #Message.categories.should == %w[Iq]
  end
end
