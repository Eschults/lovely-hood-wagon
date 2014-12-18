class UserMailer < ActionMailer::Base
  default from: "contact@lovely-hood.fr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'Bienvenue sur lovely hood!')
  end
end
