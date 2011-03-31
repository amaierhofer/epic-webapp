require 'socket'

host = 'localhost'
port = 8081

msg = 'msg>admin@psi hello my friend'
puts msg
s = TCPSocket.open(host, port)
s.puts msg
s.close

msg = 'cmd>registered_users psi'
puts msg
s = TCPSocket.open(host, port)
s.puts msg
s.close
