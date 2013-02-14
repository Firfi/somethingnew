class PasswordResetsController < ApplicationController

  before_filter :validate, :only => [:edit, :update]

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => t('user.email.reset_sent', :email => params[:email])
  end

  def edit
    # validate in before_filter after that render edit form
  end

  def update
    if @user.update_password(params[:user])
      redirect_to root_url, :notice => t('user.password.has_been_reset')
    else
      render :edit
    end
  end

  private

  def validate
    @token = params[:token]
    @user = User.awaiting_reactivation.find_by_password_reset_token(@token)
    if @user
      if @user.password_reset_sent_at < Somethingnew::Application.config.password_token_expire_time.ago
        @user.expire_password_reset_token
        expired_redirect
      end
    else
      expired_redirect
    end
  end

  def expired_redirect
    redirect_to password_reset_path, :alert => t('user.password.token.expired')
  end

end
