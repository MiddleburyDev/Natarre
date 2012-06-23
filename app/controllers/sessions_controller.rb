
class SessionsController < ApplicationController

	def create
		@user = User.authenticate params[:email], Digest::MD5.hexdigest(params[:password])
		if @user 
			session[:user_id] = @user.id
			redirect_to root_path
		else
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil

	end
end
