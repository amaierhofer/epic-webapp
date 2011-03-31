require 'blather'
require 'blather/client'
require 'yaml'

file =  File.expand_path('../../config/app_config.yml', __FILE__)
raw_config = File.read(file)
APP_CONFIG = YAML.load(raw_config)['defaults']


setup APP_CONFIG['jid'], APP_CONFIG['pw'], APP_CONFIG['host']

when_ready { puts "Connected ! send messages to #{jid.stripped}." }

def run
  Thread.new { EM.run { client.run }}
end
