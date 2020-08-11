require 'http'
require 'json'

desc 'Slack a list of AV meetings to general'
task :meetings do
  events_url = 'https://www.agileventures.org/events'

  header = "<!here> are the events for the next 24 hours. Hosted by AV members.\n\n"
  events_calendar = "<#{events_url}|Agile Ventures calendar>"
  footer = "\nCome join us!\nTo stay up to date with our events, check out the #{events_calendar}."
  one_day = 86400
  tomorrow = Time.now.utc + one_day
  rc = HTTP.get("#{events_url}.json")
  message = header
  JSON.parse(rc.body).each do |event|
    if event_start_time(event) < tomorrow
      message += "#{event['title']}: <!date^#{event_start_time(event).to_i}^{date_short_pretty} at {time}|#{event_start_time(event).utc}>\n"
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
