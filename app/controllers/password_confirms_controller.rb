class PasswordConfirmsController < ApplicationController
  def edit
    user = User.find_by_password_confirm_token!(params[:id])
    if user
      user.confirmed = true
      user.save
      redirect_to root_url, :notice => "Your account has been confirmed. You can login now using your password"
    else
      redirect_to root_url, :alert => "Error in password confirmation"
    end
  end
end
