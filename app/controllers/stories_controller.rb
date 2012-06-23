
class StoriesController < ApplicationController

	def index
		@stories = Story.all(:order => "created_at DESC")
	end

	def show
		@story = Story.find_by_id(params[:id])
	end

	def new
		@story = Story.new

	end

	def create
		@story = Story.new params[:story]
		if @story.save
			redirect_to :root
		else

		end

	end


end
