class OfferMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.offer_mailer.new_offer.subject
  #
  def new_offer(offer)
    @offer = offer

    mail to: @offer.user.offer_emails_in_string, subject: "#{@offer.user.first_name} a créé une annonce"
  end
end
