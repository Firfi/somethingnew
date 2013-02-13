class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User created. Check your email for confirmation message"
      redirect_to root_url
    else
      render "new"
    end
  end

  def guest
    @user = User.new_guest
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url
    else
      render "new"
    end
  end

end