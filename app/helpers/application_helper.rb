module ApplicationHelper

  def wrap(t, args = {}, &block)
    data = {}
    args.each_pair {|k,v|  data["data-#{k}"] = v }
    content_tag(t, data, &block);
  end

  def jdiv(args = {}, &block)
    data = {}
    args.each_pair {|k,v|  data["data-#{k}"] = v }
    content_tag(:div, data, &block);
  end

  ## password is not accessible - use sign_in page to place it in session
  ## APP_Config neither?
  def xmpp_info(user=current_user)
    domain = APP_CONFIG[:domain]
    bosh = APP_CONFIG[:bosh]
    tag(:span, {:id => "xmpp_info", 'data-domain' => domain, 'data-url' => bosh })
  end

  def epic_status
    return unless APP_CONFIG[:xmpp]
    text = "Epic service "
    css_class = "flash "
    if epic.alive?
      text += "running"
      css_class += "notice"
    else
      text += "dead"
      css_class += "error"
    end
    content_tag(:div, {:id => 'asdf', :class => css_class}) { text }
  end
end
