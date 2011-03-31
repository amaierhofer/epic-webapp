# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def js_link
    if jqm_enabled?
      link_to "noJS", { :jqm => 0 }, { :rel => "external" }
    else 
      link_to "JS", { :jqm => 1 }, { :rel => "external" }
    end
  end

  def xmpp_link
    if xmpp_enabled?
      link_to "noXMPP", { :xmpp => 0 }, { :rel => "external" }
    else 
      link_to "XMPP", { :xmpp => 1 }, { :rel => "external" }
    end
  end
end
