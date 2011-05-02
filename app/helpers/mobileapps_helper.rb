module MobileappsHelper

  def app_link(sym)
    case sym
      when :ri then link_to (ri_icon), :action => :ringit 
      when :mi then link_to (mi_icon), :action => :index
      when :brhi then link_to (brhi_icon), :action => :browserhistory
    end
  end

  def ri_icon
    image_tag 'showcase/box-button-ri-link.png'
  end

  def mi_icon
    image_tag 'showcase/box-button-mi-link.png'
  end

  def brhi_icon
    image_tag 'showcase/box-button-brhi-link.png'
  end
end 
