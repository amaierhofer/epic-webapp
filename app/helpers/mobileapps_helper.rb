module MobileappsHelper

  def btn_link_to(*args,&block)
    if args.last.is_a? Hash
      args.last['data-role'] = 'button'
    else
      args << { 'data-role' => 'button' }
    end
    link_to(*args,&block)
  end

  def app_link(sym)
    case sym
      when :ri then link_to (ri_icon), :action => :ringit 
      when :mi then link_to (mi_icon), :action => :makeit
      when :brhi then link_to (brhi_icon), :action => :browserhistory
    end
  end

  def ri_icon
    image_tag 'showcase/box-button-ri-link.png'
  end

  def mi_icon
    image_tag 'showcase/box-button-make-link.png'
  end

  def brhi_icon
    image_tag 'showcase/box-button-brhi-link.png'
  end

end
