class Story < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :comments
  has_many :votes
  belongs_to :user

  def prepare_for_viewing!
  	if !@attributes["content"].nil?
	    @attributes["content"].gsub!("\n", '</p><p>')
	else
		@attributes["content"]=""
	end
  	
  end
end
