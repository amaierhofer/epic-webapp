$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'yaml'
require 'eventmachine'
#require 'epic/xmpp_service'
require 'epic/socket_service'
require 'epic/socket_client'

module Epic
  file =  File.expand_path('../../config/app_config.yml', __FILE__)
  raw_config = File.read(file)
  CFG = YAML.load(raw_config)['defaults']
#  Epic::XMPPService.setup CFG['jid'], CFG['pw'], CFG['host']
end

pid_file = File.expand_path(File.dirname(__FILE__) + "/../log/epic.pid")

File.open(pid_file, 'w') do |f| 
  f.write(Process.pid) 
end
at_exit do
  system "rm #{pid_file}"
end

EM.run do
#  Epic::XMPPService.run
  Epic::SocketService.run 
end

