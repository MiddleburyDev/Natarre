class User < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :email, :presence => true
  validates :password, :presence => true

  has_many :stories
  has_many :votes
  has_many :comments

  def self.authenticate email, password
  	User.where(:email=>email,:password=>password).first
  end
end
