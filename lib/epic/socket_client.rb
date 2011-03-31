
require 'socket' 
require 'digest/sha1'
require 'rest_client'
module Epic
  module SocketClient

    def domain; APP_CONFIG[:domain] end
    def port; APP_CONFIG[:port] end
    def host; APP_CONFIG[:host] end
    def admin; APP_CONFIG[:admin] end

    def register(username, password)
     RestClient.post "#{admin}/users", :newusername => username, 
       :newuserpassword => password, :addnewuser => 'Add User'
#      write "cmd", "register #{username} #{domain} #{password}"
    end

    def unregister(username)
#      write "cmd", "unregister #{username} #{domain}"
    end

    def send_message(jid, msg)
      write "msg", "#{jid} #{msg}"
    end

    def alive?
      begin
        s = TCPSocket.open(host, port)
        s.close
        return true
      rescue
      end
      false
    end

    def write(cmd,data)
      begin
        s = TCPSocket.open(host, port)
        s.puts "#{cmd}>#{data}"
        s.close
        return true
      rescue
      end
      false
    end
  end
end
