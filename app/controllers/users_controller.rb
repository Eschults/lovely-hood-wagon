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
      redirect_to user_path(@user)
    else
      render :edit
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
