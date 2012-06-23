class Story < ActiveRecord::Basep
  # attr_accessible :title, :body
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
