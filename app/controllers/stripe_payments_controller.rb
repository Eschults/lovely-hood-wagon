class StripePaymentsController < ApplicationController
  def new
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @booking.cashin_price = params[:amount_cents]
    @user = @booking.user
    customer = @user.stripe_customer

    if @booking.accepted

      charge = Stripe::Charge.create(
        :amount => @booking.cashin_price.to_i, # amount in cents, again
        :currency => "eur",
        :customer => customer.id,
        :description => "#{@user.email} : booking n°#{@booking.id}"
      )
      @booking.cashed_in = true
    else
      flash[:notice] = "Ce booking n'a pas été accepté mec pay attention!"
      render :new
    end
  rescue Stripe::CardError => e
  end
end
