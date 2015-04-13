class BookingMailer < ActionMailer::Base
  default from: '"Edward Schults" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.book.subject
  #
  def book(booking)
    @booking = booking

    mail(from: "#{@booking.user.first_name} via Lovely Hood <contact@lovely-hood.com>", to: @booking.offer.user.email, subject: "Félicitations ! Vous avez une demande de réservation ! ")
  end

  def accept(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Félicitations ! Votre réservation a été acceptée ! ")
  end

  def decline(booking)
    @booking = booking

    mail(to: @booking.user.email, subject: "Demande de réservation")
  end

  # def confirm(booking)
  #   @booking = booking

  #   mail(to: @booking.user.email, subject: "Pensez à laisser un commentaire sur #{@booking.offer.user.first_name}")
  # end

  def buy(booking)
    @booking = booking

    mail(to: @booking.offer.user.email, subject: "Félicitations ! #{@booking.user.first_name} a acheté votre article #{@booking.offer.nature} !")
  end

  def review(booking)
    @booking = booking

    mail(to: @booking.offer.user.email, subject: "Pensez à laisser un commentaire sur #{@booking.user.first_name}")
  end
end
