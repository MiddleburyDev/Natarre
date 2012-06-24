
class HomeController < ApplicationController
  def index
  	redirect_to stories_index_path
  end
end
