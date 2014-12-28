class ReviewMailer < ActionMailer::Base
  default from: "contact@lovely-hood.fr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_mailer.create.subject
  #

  def view(review, recipient)
    @review = review

    mail(to: recipient.email, subject: "#{@review.booking.user.first_name} vous a laissé un commentaire")
  end
end
