class UsersController < ApplicationController
  before_action :set_user, except: [:index, :map]
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  layout 'map', only: :map

  def index
    @users = policy_scope(User)
    name_and_address_validations
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash[:alert] = "Merci de renseigner votre adresse !"
    end
  end

  def show
    authorize @user
    if @user.latitude.nil?
      redirect_to edit_user_path(@user)
      flash[:alert] = "Merci de renseigner votre adresse !"
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.street != user_params[:street] && user_params[:street]
      @user.address_verified = false
      @user.offers.each do |offer|
        offer.published = false
        offer.save
      end
      @user.save
    end
    if @user.update(user_params)
      if @user.birthday == Date.today
        @user.birthday = nil
        @user.save
      end
      if @user.activities.size == 0 && @user.sign_in_count < 3 && @user.latitude && @user.first_name
        @user.send_new_neighbor_email
        @user.create_activity :update, owner: current_user
      end
      name_and_address_validations
    else
      render :edit
    end
  end

  def map
    @users = User.where(latitude: [-90..90])
    authorize @users

    @markers = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :gender,
      :birthday,
      :phone,
      :description,
      :street,
      :zip_code,
      :city,
      :latitude,
      :longitude,
      :picture,
      :identity_proof,
      :address_proof,
      :iban,
      :bic,
      :lh_post_notif,
      :post_notif,
      :user_notif,
      :offer_notif,
      :comment_notif,
      :like_notif
    )
  end

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
end
