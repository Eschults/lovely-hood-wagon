class ReviewsController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update]

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

  end
end
