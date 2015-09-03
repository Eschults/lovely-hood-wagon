class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update]
  after_action :verify_policy_scoped, :only => [:index]
  after_action :verify_authorized, :except => [:index, :wishlist], unless: :devise_controller?
  layout 'map', only: [:index]

  def index
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash.keep[:alert] = t(".complete_profile")
    end
    @offers = policy_scope(Offer)
  end

  def mine
    @offers = current_user.offers
    authorize @offers
  end

  def new
    @offer = current_user.offers.new
    authorize @offer
    name_and_address_validations
    if params[:locale]
      @natures = NATURES[params[:locale].to_sym]
    else
      @natures = NATURES
    end
  end

  def create
    @offer = current_user.offers.new(offer_params)
    authorize @offer
    @offer.published = true
    if @offer.type_of_offer == "sell"
      @offer.sell = true
    end
    if @offer.type_of_offer == "rent" || @offer.type_of_offer == "sell"
      if NATURES[:en][:rent].index(@offer.nature)
        @offer.nature = NATURES[:rent][NATURES[:en][:rent].index(@offer.nature)]
      end
      if @offer.one_price(t('.hourly_price'), t('.weekly_price'), t('.daily_price'))
        # if @offer.picture_file_name
          if @offer.save
            if @offer.published
              @offer.send_new_offer_email
              @offer.create_activity :create, owner: current_user
            end
            redirect_to offer_path(@offer)
          else
            flash.now[:alert] = "Merci d'ajouter une description"
            render :new
          end
        # else
        #   flash.now[:alert] = "Merci d'ajouter une photo"
        #   render :new
        # end
      else
        flash.now[:alert] = "Merci de renseigner un prix"
        render :new
      end
    end
    if @offer.type_of_offer == "service"
      if NATURES[:en][:service].index(@offer.nature)
        @offer.nature = NATURES[:service][index(NATURES[:en][:service].index(@offer.nature))]
      end
      if @offer.one_price
        if @offer.save
          if @offer.published
            @offer.send_new_offer_email
            @offer.create_activity :create, owner: current_user
          end
          redirect_to offer_path(@offer)
        else
          flash.now[:alert] = "Merci d'ajouter une description"
          render :new
        end
      else
        flash.now[:alert] = "Merci de renseigner un prix"
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @offer.update(offer_params)
      if @offer.one_price(t('.hourly_price'), t('.weekly_price'), t('.daily_price'))
        respond_to do |format|
          format.html { redirect_to offer_path(@offer) }
          format.js
        end
      else
        flash.now[:alert] = "Merci de renseigner un prix"
        render :edit
      end
    else
      render :edit
    end
  end

  def show
  end

  def wishlist
    @offers = current_user.find_voted_items.reject { |voted_item| voted_item.class != Offer }
  end

  def wish
    set_offer
    @offer.liked_by current_user
    respond_to do |format|
      format.html { redirect_to offer_path(@offer) }
      format.js
    end
  end

  def unwish
    set_offer
    @offer.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to offer_path(@offer) }
      format.js
    end
  end

  private

  def name_and_address_validations
    if current_user.first_name != ""
      if current_user.last_name != ""
        if current_user.street != ""
          if current_user.zip_code != ""
            if current_user.city != ""

            else
              redirect_to edit_user_path(current_user)
              flash.keep[:alert] = "Merci de renseigner votre ville"
            end
          else
            redirect_to edit_user_path(current_user)
            flash.keep[:alert] = "Merci de renseigner votre code postal"
          end
        else
          redirect_to edit_user_path(current_user)
          flash.keep[:alert] = "Merci de renseigner votre rue"
        end
      else
        redirect_to edit_user_path(current_user)
        flash.keep[:alert] = "Merci de renseigner votre nom de famille"
      end
    else
      redirect_to edit_user_path(current_user)
      flash.keep[:alert] = "Merci de renseigner votre prénom"
    end
  end


  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end

  def offer_params
    params.require(:offer).permit(:type_of_offer, :nature, :description, :hourly_price, :daily_price, :weekly_price, :price, :picture, :public, :published, :guarantee)
  end
end
