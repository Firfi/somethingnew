class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def password_confirm(user)
    @user = user
    mail :to => user.email, :subject => "Password Confirm"
  end
end