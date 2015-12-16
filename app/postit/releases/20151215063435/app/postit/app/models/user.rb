class User < ActiveRecord::Base
  has_secure_password
  #attr_accessor :password, :password_cofirmation

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 3 }
  
  has_many :posts
  has_many :comments

  has_many :votes
end