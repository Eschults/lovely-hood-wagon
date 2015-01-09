class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  after_action :verify_authorized, :except => :index, unless: :devise_controller?
  layout 'home'

  def home
    authorize :page, :home?
  end

  def about
  end
end
