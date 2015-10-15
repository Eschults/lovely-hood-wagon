class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :wish, :unwish, :publish, :hide]
  after_action :verify_policy_scoped, :only => [:index]
  after_action :verify_authorized, :except => [:index, :wishlist], unless: :devise_controller?
  layout 'map', only: [:index, :map]

  def index
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash.keep[:alert] = t(".complete_profile")
    end
    @offers = policy_scope(Offer)
  end

  def mine
    @offers = current_user.offers
    flash.now[:alert] = t(".dbl_click")
    authorize @offers
  end

  def new
    @offer = current_user.offers.new
    authorize @offer
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash.keep[:alert] = t(".complete_profile")
    end
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
    if params[:locale]
      @natures = NATURES[params[:locale].to_sym]
    else
      @natures = NATURES
    end
    if @offer.type_of_offer == "rent" || @offer.type_of_offer == "sell"
      if NATURES[:en][:rent].index(@offer.nature)
        @offer.nature = NATURES[:rent][NATURES[:en][:rent].index(@offer.nature)]
      end
      test_offer_info_and_redirect
    end
    if @offer.type_of_offer == "service"
      if NATURES[:en][:service].index(@offer.nature)
        @offer.nature = NATURES[:service][index(NATURES[:en][:service].index(@offer.nature))]
      end
      test_offer_info_and_redirect
    end
  end

  def edit
    if params[:locale]
      @natures = NATURES[params[:locale].to_sym]
    else
      @natures = NATURES
    end
  end

  def update
    if @offer.update(offer_params)
      if @offer.one_price(t('.hourly_price'), t('.weekly_price'), t('.daily_price'))
        respond_to do |format|
          format.html { redirect_to offer_path(@offer) }
          format.js { flash.now[:notice] = t('.successfully_published', default: "Votre annonce %{offer} est désormais %{state}", offer: @offer.i18n_nature(params[:locale]), state: @offer.published ? t('.visible') : t('.hidden') ) }
        end
      else
        flash.now[:alert] = "Merci de renseigner un prix"
        render :edit
      end
    else
      render :edit
    end
  end

  def publish
    @offer.published = true
    @offer.save
    respond_to do |format|
      format.html {}
      format.js { flash.now[:notice] = t('.successfully_published', default: "Votre annonce %{offer} est désormais visible par vos voisins", offer: @offer.i18n_nature(params[:locale])) }
    end
  end

  def hide
    @offer.published = false
    @offer.save
    respond_to do |format|
      format.html {}
      format.js { flash.now[:notice] = t('.successfully_hidden', default: "Votre annonce %{offer} est désormais masquée", offer: @offer.i18n_nature(params[:locale])) }
    end
  end

  def show
  end

  def wishlist
    @offers = current_user.find_voted_items.reject { |voted_item| voted_item.class != Offer }
  end

  def wish
    @offer.liked_by current_user
    respond_to do |format|
      format.html { redirect_to offer_path(@offer) }
      format.js
    end
  end

  def unwish
    @offer.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to offer_path(@offer) }
      format.js
    end
  end

  def map
    @offers = Offer.all
    authorize @offers

    @markers = Gmaps4rails.build_markers(@offers) do |offer, marker|
      marker.lat offer.user.latitude
      marker.lng offer.user.longitude
      marker.title offer.user.first_name
      marker.infowindow "
            <div class='text-center'>
              <img src='#{offer.user.picture.url(:thumb)}' class='img-nice' width='50'>
              <a href='#{offer_path(offer)}' class='nice-link info-link'>#{offer.nature}</a>
            </div>
            <a href='#{user_path(offer.user)}' class='nice-link info-link'>#{offer.user.first_name}</a>
            <p>#{offer.user.address}</p>
            <p>#{offer.one_price('€/heure', '€/semaine', '€/jour')}</p>"
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
    authorize @offer
  end

  def offer_params
    params.require(:offer).permit(:type_of_offer, :nature, :description, :hourly_price, :daily_price, :weekly_price, :price, :picture, :public, :published, :guarantee)
  end

  def test_offer_info_and_redirect
    if @offer.one_price(t('.hourly_price'), t('.weekly_price'), t('.daily_price'))
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
