namespace :bot_test do
  desc 'Send test update notification'
  task notification: :environment do
    test_user = User.first.facebook_id

    Bot.deliver({recipient: {id: test_user.facebook_id},
      message: {
          text: 'Time for daily update, how was your day?'
      }}, access_token: ENV['ACCESS_TOKEN'])
  end
end
