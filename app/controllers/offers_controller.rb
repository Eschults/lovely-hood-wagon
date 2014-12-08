class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_offer, only: [:show, :edit, :update]
  # layout 'map', only: [:index]

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:type, :nature, :description, :hourly_price, :daily_price, :weekly_price, )
  end
end
