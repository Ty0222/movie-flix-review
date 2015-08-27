class ReviewsController < ApplicationController
	before_action :set_movie

	def index
		@reviews = @movie.reviews
	end

	def new
		@review = @movie.reviews.new
	end

	def create
		@review = @movie.reviews.new(review_attributes)

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

	def review_attributes
		params.require(:review).permit(:name, :stars, :comment, :location)
	end
end
