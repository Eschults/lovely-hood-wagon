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
      if current_user.conversation_with(@booking.offer.user)
        @conversation = current_user.conversation_with(@booking.offer.user)
        @message = Message.new(
          content: "
            Bravo, vous avez une réservation !
            Consultez vos mails !
          "
        )
        @message.writer = current_user
        @message.conversation = @conversation
      else
        @conversation = Conversation.new
        @conversation.user1 = current_user
        @conversation.user2 = @offer.user
        @message = Message.new(
          content: "
            Bravo, vous avez une réservation !
            Consultez vos mails !
          "
        )
        @message.writer = current_user
        @message.conversation = @conversation
        @message.save
      end
      redirect_to offer_booking_path(@booking.offer, @booking)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
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
