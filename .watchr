#!/usr/bin/env ruby
require 'eventmachine'
require 'em-websocket'
client = nil 
interrupted = false
running = false

puts "watchr started. #{Time.now}"

#def run_spec(file)
#  unless File.exist?(file)
#    puts "#{file} does not exist"
#    return
#  end
#  puts " --- Running #{file} ---\n\n"
#  system "rspec #{file}"
#  puts
#end
#
#
#def run_all_tests
#  running = true
#  specs = Dir['spec/**/*_spec.rb']
#  puts " --- Running standard specs ---\n\n"
#  system "rspec " + specs.join(' ')
#  running = false
#end
#
#
#Signal.trap('INT') do
#  exit if interrupted
#  return if running
#  interrupted = true
#  sleep 0.3 
#  interrupted = false
#  puts " --- Running all tests ---\n\n"
#  run_all_tests
#end
#
#watch("spec/(.*)\.rb") do |match|
#  run_all_tests
#end
#
#watch("spec/.*/*_spec\.rb") do |match|
#  run_spec match[0]
#end
#
#watch("app/(.*/.*)\.rb") do |match|
#  run_spec %{spec/#{match[1]}_spec.rb}
#end
#
#run_all_tests


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


watch "public/javascript" do 
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
