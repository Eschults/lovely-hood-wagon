class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :reply]
  before_action :set_offer, only: [:new, :create]

  def index
    @conversations = policy_scope(Conversation)
  end

  def new
    @conversation = current_user.conversations.new
    @conversation.user1 = current_user
    @conversation.user2 = @offer.user
    @conversation.messages.build
    authorize @conversation
  end

  def create
    @conversation = current_user.conversations.new(conversation_params)
    @conversation.user1 = current_user
    @conversation.user2 = @offer.user
    @message = @conversation.messages.build
    @message.writer = current_user
    authorize @conversation
    raise
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      render :new
    end
  end

  def show
  end

  def reply
    @message = current_user.messages.new(message_params)
    @message.conversation = @conversation
    if @message.save
      redirect_to offer_path(@conversation)
    else
      render :show
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

  def conversation_params
    params.require(:conversation).permit(:user1, :user2, messages_attributes: [:content])
  end
end
