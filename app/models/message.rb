class Message < ApplicationRecord

  belongs_to :user
  belongs_to :chat

  after_create_commit { MessageBroadcastJob.perform_later self }
  validates :body, presence: true, length: { maximum: 150, message: "Message is too long" }

end
