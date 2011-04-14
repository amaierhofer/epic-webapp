#!/usr/bin/env ruby
require 'eventmachine'
require 'em-websocket'
client = nil 
puts "watchr started. #{Time.now}"

def start_compass_if_not_running
  pids = `ps ax | grep compass | awk '{print $1}'`.strip.split
  if pids.length < 3
    spawn("compass watch")
  end
end

watch "app" do 
  puts "src changed."  
  client.send "reload" unless client.nil?
  start_compass_if_not_running
end

watch "views" do 
  client.send "reload" unless client.nil?
end


start_compass_if_not_running

EM::stop_event_loop if EM::reactor_running?
Thread.new do
  EM.run do
    EM::add_periodic_timer(0.3) do 
      sleep 0.3 
    end
    EM::WebSocket.start(:host => "0.0.0.0", :port => 4567) do |ws|
      puts "ws server running."
      ws.onopen do 
        puts "new client" 
        client = ws
      end
    end
  end
end
