module MessagesHelper
  def one_two_three
    %w[one two three]
  end

  def div
    tag "div"
  end

  def div_with_attr
    tag "div", { :key => "val" }
  end

  def two_divs 
    concat tag "div"
    concat tag "div"
  end

  def span_in_div
    content_tag "div" do
      tag "span"
    end
  end

  def span_in_div_2_times
    concat Proc.new { content_tag "div" do |c|
      tag "span"
    end
    }.call

    concat Proc.new { content_tag "div" do
      concat tag "span"
    end
    }.call
  end

  def message_types
    Message.categories.map do |category|
      concat radio_button_tag "message", category
      concat label_tag "message_#{category}", category
    end.join.html_safe
  end

end
