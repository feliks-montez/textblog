class Message < ActiveRecord::Base
  belongs_to :user
  
  validates :recipient_id, presence: true
  validates :body,         presence: true
end
