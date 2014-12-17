class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update]
  layout 'map', only: [:index]

  def index
    @offers = policy_scope(Offer)
    @markers = Gmaps4rails.build_markers(@offers) do |offer, marker|
      marker.lat offer.user.latitude
      marker.lng offer.user.longitude
    end
  end

  def new
    @offer = current_user.offers.new
    authorize @offer
  end

  def create
    @offer = current_user.offers.new(offer_params)
    authorize @offer
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render :new
    end
  end

  def edit
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
    authorize @offer
  end

  def offer_params
    params.require(:offer).permit(:type_of_offer, :nature, :description, :hourly_price, :daily_price, :weekly_price, :price, :picture, :public, :published)
  end
end
