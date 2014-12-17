class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :reply, :reply_server]
  before_action :set_offer, only: [:new, :create]
  respond_to :js, only: :reply

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
      redirect_to conversation_path(@conversation, anchor: "message-input")
    else
      render :new
    end
  end

  def show
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
    respond_with(@message)
  end

  def reply_server
    @message = Message.new(message_params)
    @message.writer = current_user
    @message.conversation = @conversation
    if @message.save
      redirect_to conversation_path(@conversation, anchor: "message-input")
    else
      render :new
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
    authorize @conversation
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def conversation_params
    params.require(:conversation).permit(messages_attributes: [:content])
  end
end
