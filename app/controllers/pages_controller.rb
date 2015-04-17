class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  after_action :verify_authorized, :except => :index, unless: :devise_controller?
  layout 'home', only: :home
  layout 'map', only: :poster

  def home
    authorize :page, :home?
  end

  def legal
    authorize :page, :legal?
  end

  def poster
    authorize :page, :poster?
  end

  def early_birds_poster
    authorize :page, :early_birds_poster?
  end

  def terms
    authorize :page, :terms?
  end

  def about
  end

  def sitemap
    authorize :page, :sitemap?
  end
end
