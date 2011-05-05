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
  def link_to_root
    if current_user
      link_to '', :apps_home, :id => "logo", :alt => 'epic services', :rel => 'external' 
    else
      link_to '', :root, :id => "logo", :alt => 'epic services', :rel => 'external' 
    end
  end

end
