
class StoriesController < ApplicationController
	def index
		if session[:user_id]
			@user = User.find_by_id session[:user_id]
		end
		@stories = Story.all(:order => "created_at DESC")
		@stories ||= Array.new
	end

	def prompts
    @prompt = Prompt.find(:all,:order => "created_at DESC").first
	end

	def popular


	end

	def show
		if session[:user_id]
			@user = User.find_by_id session[:user_id]
		end
		@story = Story.find_by_id(params[:id])
		@story ||= Story.find_by_id(params[:story_id])
		if @story

		else

		end
	end

	def new
		@story = Story.new
	end

	def create
		uploaded_audio = params[:story][:audio]
		if uploaded_audio
			require 'soundcloud'  
			local_audio_path = Rails.root.join('public', 'uploads', uploaded_audio.original_filename)
			File.open local_audio_path, 'w' do |file|
				file.write(uploaded_audio.read)
			end
			# create a client object with access token
			client = Soundcloud.new(:access_token => SOUNCLOUD_SECRET)#Natarre::Application.config.access_request.SOUNDCLOUD_SECRET)
			# upload an audio file
			track = client.post('/tracks', :track => {
				:title => params[:story][:title],
				:asset_data => File.new(local_audio_path, 'rb')
			})
			# store track link
			params[:story][:sc_id] = track.id
			#delete file
			File.delete(local_audio_path)
		else
			params[:story][:sc_id] = nil
		end

		@story = Story.new params[:story]
		if @story.save
			redirect_to :root
		else
			# if save fails
		end
	end

	def new
		@story = Story.new
	end

	def add_comment
		if session[:user_id]
			@comment = Comment.new
			@comment.content = params[:content]
			@comment.story_id = params[:story_id]
			@comment.user_id = params[:user_id]
			@comment.save
		end
		show
		redirect_to @story
	end
end
