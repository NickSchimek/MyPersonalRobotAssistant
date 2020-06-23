require 'sinatra'
require 'json'
require 'http'

get '/' do
  'Hello World'
end

post '/' do
  data = JSON.parse request.body.read
  user = data['event']['user']

  HTTP.post("https://slack.com/api/chat.postMessage", params: {
    token: ENV['SLACK_API_TOKEN'],
    channel: '#recordsponge_new_contributors',
    text: text(user),
    blocks: blocks(user)
  })
  :ok
end

def text user
<<-HEREDOC
Hello <@#{user}>, welcome to the Record Expungement Project!
Here are some project resources to get started:
1. Our website: recordsponge.com
2. Our <https://calendar.google.com/calendar?cid=bGo4aW91MTFwZ2ZlZnE3ZG12MGQ0M2FrcGdAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ|meetings calendar>
3. Our <https://github.com/codeforpdx/recordexpungPDX/|github repo>
Welcome aboard!
HEREDOC
end

def blocks user
  "[
    {
      'type': 'section',
      'text': {
        'type': 'mrkdwn',
        'text': 'Hello <@#{user}>, welcome to the Record Expungement Project!'
      }
    },
    {
      'type': 'section',
      'text': {
        'type': 'plain_text',
        'text': 'Here are some project resources to get started:',
        'emoji': true
      }
    },
    {
      'type': 'section',
      'text': {
        'type': 'mrkdwn',
        'text': '1. Our website: recordsponge.com'
      }
    },
    {
      'type': 'image',
      'title': {
        'type': 'plain_text',
        'text': 'recordsponge.com',
        'emoji': true
      },
      'image_url': 'https://res.cloudinary.com/da0cmt1gu/image/upload/t_media_lib_thumb/v1592229029/Screen_Shot_2020-06-15_at_10.46.47_PM_zm5c1l.png',
      'alt_text': 'marg'
    },
    {
      'type': 'section',
      'text': {
        'type': 'mrkdwn',
        'text': '2. Our <https://calendar.google.com/calendar?cid=bGo4aW91MTFwZ2ZlZnE3ZG12MGQ0M2FrcGdAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ|meetings calendar>'
      }
    },
    {
      'type': 'section',
      'text': {
        'type': 'mrkdwn',
        'text': '3. Our <https://github.com/codeforpdx/recordexpungPDX/|github repo>'
      }
    },
    {
      'type': 'section',
      'text': {
        'type': 'plain_text',
        'text': 'Our slack channels: #recordsponge #recordsponge_new_contributors #recordsponge_dev #recordsponge_web_presence #recordsponge_legislation-advocacy'
      }
    },
    {
      'type': 'section',
      'text': {
        'type': 'plain_text',
        'text': 'Welcome aboard!',
        'emoji': true
      }
    },
    {
      'type': 'divider'
    }
  ]"
end
