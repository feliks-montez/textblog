class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable

  validates :user_id, presence: true
  validates :heading, presence: true
  validates :body,    presence: true
  
  default_scope {order('created_at DESC')}
end
