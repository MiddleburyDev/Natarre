
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

		end

	end

	def index

	end
end
