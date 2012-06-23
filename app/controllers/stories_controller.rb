
class StoriesController < ApplicationController

	def index
		@stories = Story.all(:order => "created_at DESC")
		@stories ||= Array.new
	end

	def show
		@story = Story.find_by_id(params[:id])
		if @story

		else

		end
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

	def index

	end

	def create 

	end
end
