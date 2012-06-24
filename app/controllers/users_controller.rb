class UsersController < ApplicationController

	## Shows the register form.
	def register
		if !session[:user_id]
			@user = User.new
		else
			redirect_to root_path
		end

	end

	def login
		if !session[:user_id]

		else
			redirect_to root_path
		end
	end

	def edit 
		@user = User.find(session[:user_id])
		
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
