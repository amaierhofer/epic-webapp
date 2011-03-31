describe ApplicationHelper do

  it "wraps tags" do
    expected = "<div><span /></div>"
    helper.wrap(:div) { tag(:span) }.should == expected 
  end

  it "wraps tags with data params " do
    expected = "<div data-role=\"page\"><span /></div>"
    helper.wrap(:div, :role => 'page') { tag(:span) }.should == expected 
  end

  it "jdiv" do
    expected = "<div><span /></div>"
    helper.jdiv { tag(:span) }.should == expected 
  end

  it "jdiv with args" do
    expected = "<div data-role=\"page\"><span /></div>"
    helper.jdiv(:role => 'page') { tag(:span) }.should == expected 
  end
  it "#xmpp_info from config" do
    domain = APP_CONFIG[:domain]
    bosh = APP_CONFIG[:bosh]
    expected = "<span data-domain=\"psi\" data-url=\"http://localhost/xmpp-httpbind\" id=\"xmpp_info\" />" 
    helper.xmpp_info(nil).should == expected
  end

end
