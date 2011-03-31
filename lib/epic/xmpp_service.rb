require 'blather/client/dsl'
require 'user'

module Blather::DSL
  def say(to,msg)
    client.write Blather::Stanza::Message.new(to,msg)
    Message.create! :to => to, :from => jid.stripped.to_s, :body => msg
  end
end
module Epic
  module XMPPService
    extend Blather::DSL

    log = Logger.new(File.expand_path('../../../log/xmpp_service.log', __FILE__))
    log.datetime_format = "%Y-%m-%d %H:%M:%S"
    def self.run; client.run; end

    def self.config(jid,pw,host)
      setup jid, pw, host
    end


    when_ready do
      log.info "Connected ! send messages to #{jid.stripped}." 
    end

    subscription :request? do |s|
      log.info 'subscription request'
      write_to_stream s.approve!
    end


    message :chat?, :body do |m|
      log.info "#{m.from}: #{m.body}"
      say m.from, "You sent: #{m.body}"
      Message.create! :from => m.from.stripped.to_s, :to => jid.stripped.to_s, :body => m.body
    end

    message :chat?, :body => 'exit' do |m|
      say m.from, 'Exiting ...'
      shutdown
    end

  end
end
