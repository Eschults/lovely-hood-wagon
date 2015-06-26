class UserMailer < ActionMailer::Base
  default from: '"Lovely Hood" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'LH : comment ça marche ?')
  end
end
