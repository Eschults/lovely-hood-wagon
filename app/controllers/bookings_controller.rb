class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update]

  def new
    @booking = set_offer.bookings.new
    authorize @booking
  end

  def create
    @booking = set_offer.bookings.new(booking_params)
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to offer_booking_path(@booking.offer, @booking)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(offer_params)
      redirect_to offer_path(@booking.offer)
    else
      render :edit
    end
  end

  def show
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :accepted)
  end

end
