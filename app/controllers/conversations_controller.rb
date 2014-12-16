class ConversationsController < ApplicationController
  before_action :authenticate_user!
  helper_method :mailbox, :conversation
  skip_after_action :verify_policy_scoped, :verify_authorized

  # def index
  #   @conversations = policy_scope(current)
  # end

  # def create
  #   # authorize :conversation, :create?
  #   recipient_emails = conversation_params(:recipients).split(',')
  #   recipients = User.where(email: recipient_emails).all

  #   conversation = current_user.
  #     send_message(recipients, *conversation_params(:body, :subject)).conversation

  #   redirect_to conversation_path(conversation)
  # end

  # def reply
  #   # authorize :conversation, :reply?
  #   current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
  #   redirect_to conversation_path(conversation)
  # end

  # def trash
  #   # authorize :conversation, :trash?
  #   conversation.move_to_trash(current_user)
  #   redirect_to :conversations
  # end

  # def untrash
  #   # authorize :conversation, :untrash?
  #   conversation.untrash(current_user)
  #   redirect_to :conversations
  # end

  # private

  # def mailbox
  #   @mailbox ||= current_user.mailbox
  # end

  # def conversation
  #   @conversation ||= mailbox.conversations.find(params[:id])
  #   # authorize @conversation
  # end

  # def conversation_params(*keys)
  #   fetch_params(:conversation, *keys)
  # end

  # def message_params(*keys)
  #   fetch_params(:message, *keys)
  # end

  # def fetch_params(key, *subkeys)
  #   params[key].instance_eval do
  #     case subkeys.size
  #     when 0 then self
  #     when 1 then self[subkeys.first]
  #     else subkeys.map{|k| self[k] }
  #     end
  #   end
  # end
end