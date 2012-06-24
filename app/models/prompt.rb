class Prompt < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :stories
end
