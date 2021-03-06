class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :reply, :reply_server]
  before_action :set_offer, only: [:new, :create]
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index, unless: :devise_controller?
  respond_to :js, only: :reply
  layout "inbox", only: :show

  def index
    @conversations = policy_scope(Conversation)
  end

  def new
    @conversation = Conversation.new
    @conversation.user1 = current_user
    @conversation.user2 = @offer.user
    @message = Message.new
    authorize @conversation
  end

  def create
    @conversation = Conversation.new
    @conversation.user1 = current_user
    @conversation.user2 = @offer.user
    @message = Message.new(message_params)
    @message.writer = current_user
    @message.conversation = @conversation
    @message.save
    authorize @conversation
    if @conversation.save
      @conversation.send_new_message_email unless @conversation.user1_id == 2 || @conversation.user2_id == 2
      redirect_to offer_path(@offer)
    else
      render :new
    end
  end

  def new_b
    set_booking
    @conversation = Conversation.new
    @conversation.user1 = current_user
    @conversation.user2 = @booking.user
    @message = Message.new
    authorize @conversation
  end

  def create_b
    set_booking
    @conversation = Conversation.new
    @conversation.user1 = current_user
    @conversation.user2 = @booking.user
    @message = Message.new(message_params)
    @message.writer = current_user
    @message.conversation = @conversation
    @message.save
    authorize @conversation
    if @conversation.save
      @conversation.send_new_message_email unless @conversation.user1_id == 2 || @conversation.user2_id == 2
      redirect_to conversation_path(@conversation, anchor: "message-input")
    else
      render :new_b
    end
  end

  def new_u
    @conversation = Conversation.new
    @conversation.user1 = current_user
    if set_user
      @conversation.user2 = @user
    else
      @conversation.user2 = User.find(1)
    end
    @message = Message.new
    authorize @conversation
  end

  def create_u
    set_user
    @conversation = Conversation.new
    @conversation.user1 = current_user
    @conversation.user2 = @user
    @message = Message.new(message_params)
    @message.writer = current_user
    @message.conversation = @conversation
    @message.save
    authorize @conversation
    if @conversation.save
      @conversation.send_new_message_email unless @conversation.user1_id == 2 || @conversation.user2_id == 2
      redirect_to conversation_path(@conversation, anchor: "message-input")
    else
      render :new_b
    end
  end

  def show
    @conversations = current_user.conversations.sort_by{ |c| c.messages.last.created_at }.reverse
    @conversation.messages.each do |message|
      unless message.writer == current_user
        message.read_at = Time.now unless message.read_at
      end
      message.save
    end
    @message = Message.new
  end

  def reply
    @message = Message.new(message_params)
    @message.writer = current_user
    @message.conversation = @conversation
    @message.save
    @conversations = current_user.conversations.sort_by{ |c| c.messages.last.created_at }.reverse
    @conversation.send_new_message_email unless @conversation.user1_id == 2 || @conversation.user2_id == 2
  end

  def reply_server
    @message = Message.new(message_params)
    @message.writer = current_user
    @message.conversation = @conversation
    if @message.save
      @conversation.send_new_message_email unless @conversation.user1_id == 2 || @conversation.user2_id == 2
      redirect_to conversation_path(@conversation, anchor: "message-input")
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def conversation_params
    params.require(:conversation).permit(messages_attributes: [:content])
  end
end
