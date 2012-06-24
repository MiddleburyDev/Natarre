
class WebApiController < ApplicationController

	def add_view
		id = params[:id]
		@story = Story.find(id)
		@story.views+=1

	end
	def add_vote
		user_id = session[:user_id]
		story_id = params[:story_id]
		@vote = Vote.where(:user_id=>user_id,:story_id=>story_id)
		if @vote.empty?
			@vote = Vote.new
			@vote.user_id=user_id
			@vote.story_id=story_id
			@vote.save
		end
	end
end
