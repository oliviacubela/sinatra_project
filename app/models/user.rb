class User < ActiveRecord::Base 
  has_many :posts

  has_secure_password

  validates :name, presence: true
  validates :bio, presence: true
  validates :image_url, presence: true
  validates :email, presence: true, uniqueness: true
end 