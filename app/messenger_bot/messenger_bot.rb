require 'facebook/messenger'

include Facebook::Messenger

Bot.on :message do |message|
  user = User.find_or_create_by(facebook_id: message.sender['id'])
  update = user.get_update

  if user.notification_time.empty?
    message.reply(text: 'When you would like to receive notifications?')
    return
  end

  if message.quick_reply && update.mood_missing?
    update.mood = message.text
    update.save
    return
  end

  if message.text && update.message_missing?
    update.message = message.text
    update.save
    return
  end

  if update.active?
    message.reply(text: 'Do you want to submit update now?')
    return
  end
end

Bot.on :postback do |postback|
  user = User.find_or_create_by(facebook_id: postback.sender['id'])

  case message.payload
    when 'SETUP_BOT'
      postback.reply(text: 'Hello, I am your personal lifelog assistant, let me help you with setup procedure')
    when 'RESET'
      user.reset!
      message.reply('Reset has been completed')
    else
      Rails.logger.warn('Unhandled postback')
  end
end