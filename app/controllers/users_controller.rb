class UsersController < ApplicationController

	## Shows the register form.
	def register
		@user = User.new

	end

	def login


	end

	def create
		@user = User.new params[:user]
		if @user.save
			redirect_to :root_path
		else

		end
	end
end
