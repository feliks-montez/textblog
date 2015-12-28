class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :user_id,        presence: true
  validates :commentable_id, presence: true
  validates :body,           presence: true
  
  def post
    return @post if defined?(@post)
    @post = commentable.is_a?(Post) ? commentable : commentable.post
  end
  
  default_scope {order('created_at DESC')}
end
