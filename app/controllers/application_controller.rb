class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_locale
  include PublicActivity::StoreController

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_in_path_for(resource)
    if resource.latitude.nil?
      edit_user_path(resource)
    else
      posts_path
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "Il semblerait que vous ne soyez pas autorisé à effectuer cette action"
    redirect_to(root_path)
  end
end
