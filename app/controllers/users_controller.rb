class UsersController < ApplicationController
  before_action :set_user, except: :index
  after_action :verify_authorized, :except => :index, unless: :devise_controller?

  def index
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash[:alert] = "Merci de renseigner votre adresse !"
    else
      @users = policy_scope(User)
    end
  end

  def show
    if current_user.latitude.nil?
      redirect_to edit_user_path(current_user)
      flash[:alert] = "Merci de renseigner votre adresse !"
    else
      authorize @user
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
      if @user.street.include? "balard"
        @user.authorized = true
        @user.save
      end
      name_and_address_validations(user_path(@user))
    else
      render :edit
    end
  end

  private

  def name_and_address_validations(path)
    if @user.first_name != ""
      if @user.last_name != ""
        if @user.street != ""
          if @user.zip_code != ""
            if @user.city != ""
              redirect_to path
            else
              # flash[:alert] = "Merci de renseigner votre ville"
              render :edit
            end
          else
            # flash[:alert] = "Merci de renseigner votre code postal"
            render :edit
          end
        else
          # flash[:alert] = "Merci de renseigner votre rue"
          render :edit
        end
      else
        # flash[:alert] = "Merci de renseigner votre nom de famille"
        render :edit
      end
    else
      # flash[:alert] = "Merci de renseigner votre prénom"
      render :edit
    end
  end

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
      :bic
    )
  end
end
