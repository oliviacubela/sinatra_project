class Post < ActiveRecord::Base 
  belongs_to :user 
  
  validates :title, presence: true
  validates :content, presence: true
  validates :image_url, presence: true
end