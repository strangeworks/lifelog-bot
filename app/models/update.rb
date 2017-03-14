class Update < ApplicationRecord
  enum mood: [:good, :normal, :bad]

  belongs_to :user

  scope :active, -> () { where('mood IS NULL OR message IS NULL') }

  def mood_missing?
    mood.empty?
  end

  def message_missing?
    message.empty?
  end

  def active?
    message_missing? || mood_missing?
  end
end
