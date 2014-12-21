class UsersController < ApplicationController
  before_action :set_user

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      @user.save
      name_and_address_validations(user_path(@user))
    else
      render :edit
    end
  end


  private

  def name_and_address_validations(path)
    if current_user.first_name != ""
      if current_user.last_name != ""
        if current_user.street_number != ""
          if current_user.street_name != ""
            if current_user.zip_code != ""
              if current_user.city != ""
                redirect_to path
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
