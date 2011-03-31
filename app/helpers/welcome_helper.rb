module WelcomeHelper
  def add_jasmine
    path = "/jasmine/lib/jasmine-1.0.1"

    content_for(:head) { stylesheet_link_tag "#{path}/jasmine.css" }
    %w[jasmine.js jasmine-html.js].each do |file|
      content_for(:head) { javascript_include_tag "#{path}/#{file}" }
    end

    ##path = "/jasmine"
    ##%w[src/Player.js src/Song.js spec/SpecHelper.js spec/PlayerSpec.js].each do |file|
    ##  content_for(:head) { javascript_include_tag "#{path}/#{file}" }
    ##end

    content_for(:head) { javascript_include_tag "xmpp/jquery.xmpp.js" }
    content_for(:head) { javascript_include_tag "xmpp/jquery.xmpp.extensions.js" }
    content_for(:head) { javascript_include_tag "xmpp/jquery.xmpp.test.js" }
    
  end
end
