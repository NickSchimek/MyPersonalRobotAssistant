require 'sinatra'
require 'json'
require 'http'

get '/' do
  'Hello World'
end

post '/' do
  data = JSON.parse request.body.read

  rc = HTTP.post("https://slack.com/api/chat.postMessage", params: {
    token: ENV['SLACK_API_TOKEN'],
    channel: '#botleytestchannel',
    text: 'hello @poppa_nick'
  })
  logger.info JSON.pretty_generate(JSON.parse(rc.body))
  :ok
end
