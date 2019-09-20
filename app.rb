require 'sinatra'
require 'json'
require 'http'

get '/' do
  'Hello World'
end

post '/' do
  data = JSON.parse request.body.read
  user = data['event']['user']
  text = "Hello <@#{user}>, welcome to the Record Expungement Project!\n\nYour first task is to Fork, Clone, and install the app at https://github.com/codeforpdx/recordexpungPDX\n If any issues arrise please feel free to reach out to anyone. There are many solutions documented and if you have issues then we ask that you help improve our documentation and submit a PR to update the README :)\n\nAlso feel free to join the #record_expung_gh_updt channel which posts github activity related to the project.\n\nIf interested in the front-end (which is React) then please say hello to @Max Wallace to see what's currently happening there.\nIf the back-end suits you more then please say hello to @erik, @Jordan Witte, or @poppa_nick to see where you can help out.\n\nLast but not least, once you get the project installed and found an issue to work then send @poppa_nick your github user name and the issue # your going to work on and he'll get you added to the team.\n\nFinally please say hello via slack or in person if we're still strangers.\n\nThanks! and welcome aboard."
  rc = HTTP.post("https://slack.com/api/chat.postMessage", params: {
    token: ENV['SLACK_API_TOKEN'],
    channel: '#botleytestchannel',
    text: text
  })
  :ok
end
