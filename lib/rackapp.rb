## use with 
# rackup rack-example.ru -p 3000
use Rack::ContentLength
app = lambda do |env| 
  [200, { 'Content-Type' => 'text/html' }, 'Hello World'] 
end
run app

