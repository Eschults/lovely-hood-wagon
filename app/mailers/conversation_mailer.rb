class ConversationMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.conversation_mailer.new_message.subject
  #
  def new_message
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
