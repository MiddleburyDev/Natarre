class Story < ActiveRecord::Base
  # attr_accessible :title, :body
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment :avatar, :presence => true,
  :content_type => { :content_type => "image/jpg" }
end
