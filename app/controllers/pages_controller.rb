class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    authorize :page, :home?
  end

  def about
  end
end
