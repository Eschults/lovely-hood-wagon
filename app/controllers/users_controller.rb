class UsersController < ApplicationController
  before_action :set_user
  after_action :verify_authorized, :except => :index, unless: :devise_controller?

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
    if @user.address_changed?
      @user.address_verified = false
      @user.offers.each do |offer|
        offer.published = false
      end
    end
    if @user.save
      name_and_address_validations(user_path(current_user))
    else
      render :edit
    end
  end


  private

  def name_and_address_validations(path)
    if @user.first_name != ""
      if @user.last_name != ""
        if @user.street_number != ""
          if @user.street_name != ""
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
          # flash[:alert] = "Merci de renseigner votre n° de rue"
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
      :gender,
      :birthday,
      :phone,
      :description,
      :street_number,
      :street_name,
      :zip_code,
      :city,
      :latitude,
      :longitude,
      :picture,
      :identity_proof,
      :address_proof
    )
  end
end
