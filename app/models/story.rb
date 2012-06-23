class Story < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :comments
  
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }
<<<<<<< HEAD
  validates_attachment :avatar, :presence => true,
  :content_type => { :content_type => "image/jpg" }
=======

>>>>>>> 86dc18f9882fb411ceab733ee76a428cc16d0faa
end
