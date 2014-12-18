class BookingMailer < ActionMailer::Base
  default from: "contact@lovely-hood.fr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.book.subject
  #
  def book(booking)
    @booking = booking

    mail(to: @booking.offer.user.email, subject: "Félicitations ! Vous avez une demande de réservation ! ")
  end

  def accept(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Félicitations ! Votre réservation a été acceptée ! ")
  end

  def decline(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Demande de réservation")
  end
end
