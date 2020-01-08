require 'sinatra'
require 'json'
require 'http'

get '/' do
  'Hello World'
end

post '/' do
  data = JSON.parse request.body.read
  user = data['event']['user']
  text = "Hello <@#{user}>, welcome to the Record Expungement Project!\n\nHead over to https://github.com/codeforpdx/recordexpungPDX/ to get famaliar with the project.\n\nWelcome aboard!"
  rc = HTTP.post("https://slack.com/api/chat.postMessage", params: {
    token: ENV['SLACK_API_TOKEN'],
    channel: '#record_expung',
    text: text
  })
  :ok
end
