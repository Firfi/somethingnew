class PasswordResetsController < ApplicationController

  before_filter :validate, :only => [:edit, :update]

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions on email: #{params[:email]} "
  end

  def edit
    # init in filter
  end

  def update
    if @user.update_password(params[:user])
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end

  private

  def validate
    @token = params[:token]
    @user = User.awaiting_activation.find_by_password_reset_token(@token)
    if @user
      if @user.password_reset_sent_at < 2.hours.ago
        @user.expire_password_reset_token
        expired_message
      end
    else
      expired_message
    end
  end

  def expired_message
    redirect_to password_reset_path, :alert => "Password reset token has been expired"
  end


end
