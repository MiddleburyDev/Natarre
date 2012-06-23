class Story < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :comments
  
<<<<<<< HEAD
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }
<<<<<<< HEAD
  validates_attachment :avatar, :presence => true,
  :content_type => { :content_type => "image/jpg" }
=======
=======
  # has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }
>>>>>>> Add Prompts Controller

>>>>>>> 86dc18f9882fb411ceab733ee76a428cc16d0faa
end
