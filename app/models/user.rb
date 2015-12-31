require 'carrierwave'
class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments
  
  mount_uploader :avatar, ImageUploader
  
  before_save {|user| user.email = user.email.downcase if user.email}
  
  VALID_EMAIL_REGEX = /\A.+@.+\z/i
  
  validates :name,                  presence: true
  validates :email,                 presence: true,
                                    format: {with: VALID_EMAIL_REGEX},
                                    uniqueness: {case_sensitive: false}
  validates :password,              presence: true, on:[:new, :create]
  validates :password_confirmation, presence: true, on:[:new, :create]

  def full_name
    fname + ' ' + lname
  end
  
  scope :authors, -> { where(author: true) }
  scope :registered, -> { where("email IS NOT NULL") }
end
