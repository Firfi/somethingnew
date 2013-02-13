class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) && user.confirmed?
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid or user is not confirmed yet."
      render 'main/index'
    end
  end
  def destroy
    current_user.destroy if current_user.guest?
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged out!"
  end
end
