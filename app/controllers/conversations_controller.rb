class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :reply]

  def index
    @conversations = policy_scope(Conversation)
  end

  def new
    @conversation = current_user.conversations.new
    authorize @conversation
  end

  def create
    @conversation = current_user.offers.new(conversation_params)
    authorize @conversation
    if @conversation.save
      redirect_to offer_path(@conversation)
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

  def message_params
    params.require(:message).permit(:writer, :content)
  end

  def conversation_params
    params.require(:conversation).permit(:user1, :user2)
  end
end
