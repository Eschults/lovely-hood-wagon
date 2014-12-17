class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :reply]
  before_action :set_offer, only: [:new, :create]
  respond_to :js, only: :reply

  def index
    @conversations = policy_scope(Conversation)
  end

  def new
    @conversation = Conversation.new
    @conversation.user1 = current_user
    @conversation.user2 = @offer.user
    authorize @conversation
  end

  def create
    @conversation = Conversation.new
    @conversation.user1 = current_user
    @conversation.user2 = @offer.user
    @message = Message.new
    @message.content = params[:conversation][:message][:content]
    @message.writer = current_user
    @message.conversation = @conversation
    @message.save
    authorize @conversation
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      render :new
    end
  end

  def show
    @message = Message.new
  end

  def reply
    @message = Message.new(message_params)
    @message.writer = current_user
    @message.conversation = @conversation
    @message.save
    respond_with(@message)
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
