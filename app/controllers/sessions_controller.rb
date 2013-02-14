class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) && user.confirmed?
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_url, notice: t('session.logged.in')
    else
      flash.now.alert = t('session.password.not.confirmed')
      render 'main/index'
    end
  end

  def destroy
    destroy_guest
    redirect_to root_url, notice: t('session.logged.out')
  end


end
