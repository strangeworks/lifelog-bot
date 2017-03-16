require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  if message.quick_reply && message.quick_reply.match?('time')
    message.reply(text: 'Thank you I will notify you very soon, have a good and productive day!')
  end

  if message.quick_reply && message.quick_reply == 'setup_started'
    User.find_or_create_by(facebook_id: message.sender['id'])

    message.reply(
        text: 'When should I ask you about your day?',
        quick_replies: [
            {
                content_type: 'text',
                title: 'Every evening',
                payload: 'time_morning'
            },
            {
                content_type: 'text',
                title: 'Every evening',
                payload: 'time_evening'
            }
        ])
  end
end

Bot.on :postback do |postback|
  case postback.payload
    when 'SETUP_BOT'
      postback.reply(
        text: 'Hello, I am your personal lifelog assistant, let me help you with setup procedure',
        quick_replies: [
          {
            content_type: 'text',
            title: 'I want to set you up',
            payload: 'setup_started'
          }
        ]
      )
    when 'RESET'
      # TODO: we will implement reset functionality soon
      postback.reply(text: 'Reset has been completed')
    else
      Rails.logger.warn('Unhandled postback')
  end
end