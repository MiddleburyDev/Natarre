
class PromptsController < ApplicationController

	def new
	end

	def create
		@prompt = Prompt.new
		@prompt.question = params[:question]
		@prompt.save
		redirect_to prompts_path

	end

end
