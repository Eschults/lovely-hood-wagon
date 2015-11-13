class SessionsController < Devise::SessionsController
  after_filter :clear_sign_signout_flash, :only => [:create, :destroy]
  def create
    params[:user].merge!(remember_me: 1)
    super
  end

protected

  def clear_sign_signout_flash
    if flash.keys.include?("notice")
      flash.delete(:notice)
    end
  end
end