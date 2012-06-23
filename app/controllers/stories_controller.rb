
class StoriesController < ApplicationController

	def show
		@story = Story.find_by_id(params[:id])

	end

	def index

	end

	def create 

	end
end
