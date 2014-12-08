class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_offer, only: [:show, :edit, :update]
  # layout 'map', only: [:index]

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.user = current_user
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render :new
    end
  end

  def edit
    redirect_to root unless current_user.id == @offer.user.id
  end

  def update
    if @offer.update(offer_params)
      redirect_to offer_path(@offer)
    else
      render :edit
    end
  end

  def show
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:type, :nature, :description, :hourly_price, :daily_price, :weekly_price, :picture)
  end
end
