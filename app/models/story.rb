class Story < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :comments
  belongs_to :user

end
