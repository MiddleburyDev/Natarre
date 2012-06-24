class UsersController < ApplicationController

	## Shows the register form.
	def register
		@user = User.new

	end

	def login

	end

	def create
		@user = User.new params[:user]
		@user.password=Digest::MD5.hexdigest(@user.password)
		if @user.save
			redirect_to login_path
		else

		end
	end
end
