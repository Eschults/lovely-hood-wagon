class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :confirm]
  after_action :verify_policy_scoped, :only => :index

  def new
    @booking = set_offer.bookings.new
    authorize @booking
  end

  def create
    @booking = set_offer.bookings.new(booking_params)
    @booking.user = current_user
    lh = User.find_by_first_name("Lovely hood")
    authorize @booking
    if @booking.save
      if @offer.user.conversation_with(lh)
        @conversation = @offer.user.conversation_with(lh)
        @message = Message.new(
          content: "Bravo, <a href='/users/#{@booking.user.id}'>#{@booking.user.first_name}</a> vous a envoyé une nouvelle <a href='/offers/#{@offer.id}/bookings/#{@booking.id}/edit'>demande</a> !"
        )
        @message.writer = lh
        @message.conversation = @conversation
        @message.save
      else
        @conversation = Conversation.new
        @conversation.user1 = lh
        @conversation.user2 = @offer.user
        @message = Message.new(
          content: "Bravo, <a href='/users/#{@booking.user.id}'>#{@booking.user.first_name}</a> vous a envoyé une nouvelle <a href='/offers/#{@offer.id}/bookings/#{@booking.id}/edit'>demande</a> !"
        )
        @message.writer = lh
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
      if @booking.user.conversation_with(lh)
        @conversation = @booking.user.conversation_with(lh)
        @message = Message.new(
          content: "Vous avez une réponse à votre <a href='/offers/#{@booking.offer.id}/bookings/#{@booking.id}'>réservation</a> !"
        )
        @message.writer = lh
        @message.conversation = @conversation
        @message.save
      else
        @conversation = Conversation.new
        @conversation.user1 = lh
        @conversation.user2 = @booking.user
        @message = Message.new(
          content: "Vous avez une réponse à votre <a href='/offers/#{@booking.offer.id}/bookings/#{@booking.id}'>réservation</a> !"
        )
        @message.writer = lh
        @message.conversation = @conversation
        @message.save
      end
      redirect_to offer_path(@booking.offer)
    else
      render :edit
    end
  end

  def confirm
    if @booking.update(booking_params)
      redirect_to offers_path
    else
      redirect_to root
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
    params.require(:booking).permit(:start_date, :end_date, :start_hour, :end_hour, :accepted, :owner_validation, :client_validation)
  end

end
