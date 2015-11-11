class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]


	def new
	end

	def create
		if user = User.authenticate(params[:email], params[:password])
			session[:user_id] = user.username
			flash[:notice] = "Welcome back #{user.first_name}!"
			redirect_to (session[:intended_url] || user_path(user.username))
			session[:intended_url] = nil
		else
			flash.now[:alert] = "Invalid email/username and/or password combination!"
			render :new
		end						
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: "You have successfully logged out!"
	end
end