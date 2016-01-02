class SessionsController < ApplicationController
  def github
    @user = User.find_or_create_from_omniauth(auth_hash)
    log_in(@user)
    flash.notice = "You are now signed in as #{@user.username}!"
    redirect_to root_url
  end

  def destroy
    log_out if logged_in?
    flash.notice = "You have been signed out"
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
