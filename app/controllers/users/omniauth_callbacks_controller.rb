class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable
  def facebook
    user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      remember_me(user)
      # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:alert] = "We need your email"
      redirect_to new_user_registration_url
    end
  end
end