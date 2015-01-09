class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_in_path_for(resource)
    offers_path
  end

  private

  def user_not_authorized
    flash[:alert] = "Désolé, je ne peux pas te laisser faire ça."
    redirect_to(root_path)
  end
end
