require 'sinatra'
require 'json'

get '/' do
  'Hello World'
end

post '/' do
  data = JSON.parse request.body.read
  data['challenge']
end
