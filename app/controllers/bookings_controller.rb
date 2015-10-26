class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update]
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index, unless: :devise_controller?

  def new
    @booking = set_offer.bookings.new
    authorize @booking
    unless @booking.offer.one_price_int == 0
      if current_user.stripe_customer_token
        if Stripe::Customer.retrieve(current_user.stripe_customer_token).default_source != ""
        else
          flash.keep[:alert] = t(".you_need_a_cb")
          redirect_to new_offer_stripe_customer_path(@booking.offer)
        end
      else
        flash.keep[:alert] = t(".you_need_a_cb")
        redirect_to new_offer_stripe_customer_path(@booking.offer)
      end
    end
  end

  def create
    @booking = set_offer.bookings.new(booking_params)
    @booking.user = current_user
    lh = User.find_by_first_name("Lovely Hood")
    authorize @booking
    if current_user.stripe_customer_token || @booking.offer.one_price_int == 0
      if @booking.offer.one_price_int == 0 || Stripe::Customer.retrieve(current_user.stripe_customer_token ? current_user.stripe_customer_token : "").default_source != ""
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
      else
        redirect_to new_offer_stripe_customer_path(@offer)
      end
    else
      redirect_to new_offer_stripe_customer_path(@offer)
    end
  end

  def edit
  end

  def update
    lh = User.find_by_first_name("Lovely Hood")
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
      @booking.send_answer_email
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def show
  end

  def buy
    lh = User.find_by_first_name("Lovely Hood")
    set_booking
    @booking.offer.sold = true
    @booking.offer.save
    @conversation = @booking.offer.user.conversation_with(lh)
    if params[:locale] == "en"
      @message = Message.new(
        content: "Congratulations! #{@booking.user.first_name} bought your item #{@booking.offer.i18n_nature('en')}!
        You will receive a #{(@booking.booking_price * 0.96).floor}$ payment on your account."
      )
    else
      @message = Message.new(
        content: "Félicitations ! #{@booking.user.first_name} a acheté votre article #{@booking.offer.nature} !
        Nous déclenchons le paiement de #{(@booking.booking_price * 0.96).floor}€ sur votre compte."
      )
    end
    @message.writer = lh
    @message.conversation = @conversation
    @message.save
    redirect_to new_booking_review_path(@booking)
  end

  def cancel
    set_booking
    if @booking.update(booking_params)
      redirect_to new_booking_review_path(@booking)
    else
      redirect_to root_path
    end
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
    params.require(:booking).permit(:start_date, :end_date, :start_hour, :end_hour, :accepted, :cashed_in, :cashed_out, :cancelled)
  end

end
