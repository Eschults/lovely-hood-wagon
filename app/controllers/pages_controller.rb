class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'home'

  def home
    authorize :page, :home?
  end

  def about
  end
end
