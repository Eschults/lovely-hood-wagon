class ReviewsController < ApplicationController
  before_action :set_booking, only: [:new, :create]
  before_action :set_offer, only: [:show]

  def new
  end

  def create
  end

  def show
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :communication_rating, :punctuality_rating, :respect_rating, :quality_price_rating, :recommendation)
  end
end
