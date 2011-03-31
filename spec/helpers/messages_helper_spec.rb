describe MessagesHelper do
  it "returns one, two three " do
    helper.one_two_three.should == %w[one two three]
  end

  it "#div returns div" do
    helper.div.should == "<div />"
  end


  it "#div_with_attr returns div with attr" do
    helper.div_with_attr.should == "<div key=\"val\" />"
  end


  it "returns two tags" do
    helper.two_divs.should == "<div /><div />"
  end

  it "#div #span " do
    helper.span_in_div.should == "<div><span /></div>"
  end


  it "#div #span twice" do
    helper.span_in_div_2_times.should == "<div><span /></div>" * 2
  end

  it "#message_types returns radio buttons" do
    #puts helper.message_types.inspect
  end
end
