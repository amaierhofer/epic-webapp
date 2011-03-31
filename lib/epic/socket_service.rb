## 
# We should communicate the success of failure of an operation
#  system: $?.exitstatus == 0
#  msg: nodeonline? 
#
# this is our interface from rails to filesystem and ejabberd
#
module Epic
  module SocketService


    def self.run
      EM::start_server "127.0.0.1", 8081, Epic::SocketService
    end
    def log
      if @log.nil?
        @log = Logger.new(File.expand_path('../../../log/socket_service.log', __FILE__))
        @log.datetime_format = "%Y-%m-%d %H:%M:%S"
      end
      @log 
    end
    def post_init
      log.info "someone connected to the echo server!"
    end

    def receive_data data
      log.info "recieved: #{data}"
      group = /^(.*?)>(.*)$/.match (data)
      return if group.nil? or group.length != 3
      send_msg(group[2]) if group[1] == 'msg'
      exec_ejabberd(group[2]) if group[1] == 'cmd'
    end

    def exec_ejabberd data
      log.info "ejabberdctl #{data}"
      system "ejabberdctl #{data}"
      log.info "status: #{$?.exitstatus}"
    end

    def send_msg data
      group = /^(.*?)\s(.*)$/.match(data)
      log.info "sending #{group[1]}: #{group[2]}"
      Epic::XMPPService.say group[1], group[2]
    end
  end
end
