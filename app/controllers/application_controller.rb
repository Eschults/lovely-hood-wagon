class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_in_path_for(resource)
    if (request.env['omniauth.origin'] && resource.latitude.nil?) || resource.authorized.nil?
      edit_user_path(resource)
    else
      offers_path
    end
  end

  private

  def user_not_authorized
    if current_user.authorized
      flash[:alert] = "Il semblerait que vous ne soyez pas autorisé à effectuer cette action"
    else
      flash[:alert] = "Lovely hood est actuellement en version beta, et n'est ouverte qu'à la création d'annonces. Pour plus d'information, écrivez-nous à contact@lovely-hood.fr."
    end
    redirect_to(root_path)
  end
end
