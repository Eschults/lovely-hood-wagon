class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update]
  after_action :verify_policy_scoped, :only => :index
  layout 'map', only: [:index]

  def index
    name_and_address_validations
    @offers = policy_scope(Offer)
  end

  def new
    name_and_address_validations
    @offer = current_user.offers.new
    authorize @offer
  end

  def create
    @offer = current_user.offers.new(offer_params)
    authorize @offer
    if @offer.save
      if @offer.one_price
        redirect_to offer_path(@offer)
      else
        flash[:alert] = "Merci de renseigner un prix"
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @offer.update(offer_params)
      if @offer.one_price
        redirect_to offer_path(@offer)
      else
        flash[:alert] = "Merci de renseigner un prix"
        render :edit
      end
    else
      render :edit
    end
  end

  def show
    @verif = 0
    unless @offer.user.identity_verified
      @verif += 1
    end
    unless @offer.user.address_verified
      @verif += 1
    end
  end

  private

  def name_and_address_validations
    if current_user.first_name != ""
      if current_user.last_name != ""
        if current_user.street_number != ""
          if current_user.street_name != ""
            if current_user.zip_code != ""
              if current_user.city != ""

              else
                flash[:alert] = "Merci de renseigner votre ville"
                redirect_to edit_user_path(current_user)
              end
            else
              flash[:alert] = "Merci de renseigner votre code postal"
              redirect_to edit_user_path(current_user)
            end
          else
            flash[:alert] = "Merci de renseigner votre rue"
            redirect_to edit_user_path(current_user)
          end
        else
          flash[:alert] = "Merci de renseigner votre n° de rue"
          redirect_to edit_user_path(current_user)
        end
      else
        flash[:alert] = "Merci de renseigner votre nom de famille"
        redirect_to edit_user_path(current_user)
      end
    else
      flash[:alert] = "Merci de renseigner votre prénom"
      redirect_to edit_user_path(current_user)
    end
  end


  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end

  def offer_params
    params.require(:offer).permit(:type_of_offer, :nature, :description, :hourly_price, :daily_price, :weekly_price, :price, :picture, :public, :published)
  end
end
