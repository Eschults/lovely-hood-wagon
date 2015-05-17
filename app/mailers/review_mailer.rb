class ReviewMailer < ActionMailer::Base
  default from: '"Lovely Hood" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_mailer.create.subject
  #

  def view(review, recipient)
    @review = review

    mail(to: recipient.email, subject: "#{@review.review_type == "cto" ? @review.booking.user.first_name : @review.booking.offer.user.first_name} vous a laissé un commentaire")
  end
end
