require 'http'
require 'json'

desc 'Slack a list of AV meetings to general'
task :meetings do
  header = "<!here> are the events for the next 24 hours. Hosted by AV members.\n\n"
  footer = "\nCome join us!"
  one_day = 86400
  tomorrow = Time.now.utc + one_day
  rc = HTTP.get('https://www.agileventures.org/events.json')

  message = header
  JSON.parse(rc.body).each do |event|
    if event_start_time(event) < tomorrow
      message += "#{event['title']} at: #{event_start_time(event).utc}\n"
    end
  end
  message += footer

  unless message.length > (header + footer).length
    message = "No events were found for today: Happy coding!"
  end

  HTTP.post("https://slack.com/api/chat.postMessage", params: {
    token: ENV['AV_POPPA_NICK_TOKEN'],
    channel: '#general',
    text: message
  })

end

def event_start_time(event)
  Time.strptime(event['start'] + '+0000', '%Y-%m-%dT%H:%M:%S%z')
end
