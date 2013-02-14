class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => t('user.email.subject.password_reset')
  end

  def password_confirm(user)
    @user = user
    mail :to => user.email, :subject => t('user.email.subject.password_confirm')
  end
end