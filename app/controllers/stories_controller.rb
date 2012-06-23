
class StoriesController < ApplicationController

	def show
		@story = Story.find_by_id(params[:id])

	end


end
