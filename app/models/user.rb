class User < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :email, :presence => true
  validates :password, :presence => true

  has_many :stories
  has_many :votes
  has_many :lists
  has_many :comments

  def self.authenticate email, password
  	User.where(:email=>email,:password=>password).first
  end
  def has_voted_for? story_id
  	if Vote.where( :user_id => @attributes["id"], :story_id => story_id ).empty?
  		return false
  	else
  		return true
  	end
  end
end
