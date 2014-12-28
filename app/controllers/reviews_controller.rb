class ReviewsController < ApplicationController
  before_action :set_booking, only: [:new, :create, :edit, :update]
  before_action :set_review, only: [:edit, :update, :show]
  respond_to :js, only: :update

  def new
    @review = @booking.reviews.new
    authorize @review
  end

  def create
    @review = @booking.reviews.new(review_params)
    authorize @review
    if @booking.user == current_user
      @review.review_type = "cto"
    else
      @review.review_type = "otc"
    end
    if @review.save
      redirect_to edit_booking_review_path(@booking, @review)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
  end

  def show
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  def review_params
    params.require(:review).permit(:comment, :communication_rating, :punctuality_rating, :respect_rating, :quality_price_rating, :recommendation)
  end
end
