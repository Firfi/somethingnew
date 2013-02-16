require 'spec_helper'

password_reset_expire_time = Somethingnew::Application.config.password_token_expire_time

describe "PasswordResets" do

  before :each do
    reset_email
  end

  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit login_path
    click_link "password"
    fill_in "Email", :with => user.email
    click_button t('user.password.reset.button')
    page.should have_content(t('user.email.reset_sent', :email => user.email))
    last_email.to.should include(user.email)
  end
  it "does not email invalid user when requesting password reset" do
    visit login_path
    click_link "password"
    email = "nobody@example.com"
    fill_in "Email", :with => email
    click_button t('user.password.reset.button')
    current_path.should eq(root_path)
    page.should have_content(t('user.email.reset_sent', :email => email))
    last_email.should be_nil
  end

  it "updates the user password when confirmation matches" do
    user = FactoryGirl.create(:user,
                              :password_reset_token => "something",
                              :password_reset_sent_at => (password_reset_expire_time - 5.minute).ago)
    visit password_edit_path(user.password_reset_token)
    fill_in 'user_password', :with => "foobar"
    click_button t('user.password.update.button')
    page.should have_content(t('activerecord.errors.messages.confirmation'))
    fill_in 'user_password', :with => "foobar"
    fill_in 'user_password_confirmation', :with => "foobar"
    click_button t('user.password.update.button')
    page.should have_content(t('user.password.has_been_reset'))
  end

  it "reports when password token has expired" do
    user = FactoryGirl.create(:user,
                              :password_reset_token => "something",
                              :password_reset_sent_at => (password_reset_expire_time + 5.minute).ago)
    visit password_edit_path(user.password_reset_token)
    page.should have_content("expired")
  end

  it "reports that token has expired when token is invalid" do
    visit password_edit_path("invalid")
    page.should have_content("expired")
  end
end
