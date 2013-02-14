class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      if current_user && current_user.guest?
        current_user.move_to(@user)
        destroy_guest
      end
      flash[:notice] = t('user.created.check_email')
      redirect_to root_url
    else
      render 'new'
    end
  end

  def guest
    @user = User.new_guest
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url
    else
      render 'new'
    end
  end

end