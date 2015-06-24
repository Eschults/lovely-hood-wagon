class StripeCustomersController < ApplicationController
  # layout "map", only: :new
  def new
    @offer = Offer.find(params[:offer_id])
  end

  def create
    @offer = Offer.find(params[:offer_id])
    customer = current_user.stripe_customer
    card = current_user.create_card(params[:stripeToken])
    if Stripe::Customer.retrieve(current_user.stripe_customer_token).default_source != nil
      redirect_to new_offer_booking_path(@offer)
    else
      render :new
    end

  # rescue Stripe::InvalidRequestError => e
  #   logger.error "Erreur Stripe : #{e.message}"
  #   errors.add :base, "There was a problem with your credit card."
  #   false
  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to stripe_customers_path
  end
end
