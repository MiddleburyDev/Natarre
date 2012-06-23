class Story < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :comments
  
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }

end
