class Story < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :comments
  belongs_to :user

  def prepare_for_viewing!

    @attributes["content"].gsub!("\n", '</p><p>')
  	
  end
end
