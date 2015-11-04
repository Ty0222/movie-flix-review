class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def require_login
		unless logged_in?
			session[:intended_url] = request.url
			redirect_to login_url
		end 
  end

  def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		current_user != nil
	end

	def current_user?(user)
		user == current_user
	end

	helper_method :current_user?
	helper_method :current_user
end
