class ReviewsController < ApplicationController
	skip_before_action :require_login, only: [:index]
	before_action :set_movie

	def index
		@reviews = @movie.reviews
	end

	def new
		@review = @movie.reviews.new
	end

	def create
		@review = @movie.reviews.new(review_params)
		@review.user = current_user

		if @review.save
			redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
		else
			render :new
		end
	end

private

	def set_movie
		@movie = Movie.find(params[:movie_id])
	end

	def review_params
		params.require(:review).permit(:stars, :comment, :location)
	end
end