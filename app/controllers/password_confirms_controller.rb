class PasswordConfirmsController < ApplicationController
  def edit
    user = User.find_by_password_confirm_token(params[:id])
    if user
      user.confirmed = true
      user.password_confirm_token = nil
      user.save
      redirect_to :login, :notice => t('user.email.confirmed')
    else
      redirect_to root_url, :alert => t('user.email.confirmation_error')
    end
  end
end
