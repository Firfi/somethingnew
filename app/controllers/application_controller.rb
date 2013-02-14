class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, alert: t('session.not.authorized') if current_user.nil?
  end

  def destroy_guest
    current_user.destroy if current_user.guest?
    cookies.delete(:auth_token)
  end

  def handle_unverified_request
    #TODO add here code to empty the session
    raise ActionController::InvalidAuthenticityToken
  end

end
