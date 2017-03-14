class AddNotificationTimeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_time, :datetime
  end
end
