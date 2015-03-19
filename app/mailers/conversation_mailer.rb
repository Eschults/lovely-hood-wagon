class ConversationMailer < ActionMailer::Base
  default from: '"Edward Schults" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.conversation_mailer.new_message.subject
  #
  def new_message(conversation)
    @conversation = conversation

    mail to: @conversation.other_user(@conversation.messages.last.writer).email, subject: "#{@conversation.messages.last.writer.first_name} vous a envoyé un message sur LH"
  end
end
