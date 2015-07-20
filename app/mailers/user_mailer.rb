class UserMailer < ActionMailer::Base
  default from: '"Lovely Hood" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail(to: @user.email, subject: '[LH] Comment ça marche ?')
  end

  def new_neighbor(user)
    @user = user

    mail(to: "contact@lovely-hood.com", bcc: @user.neighbor_notif_emails_in_string, subject: "#{@user.first_name} a rejoint votre voisinage")
  end
end
