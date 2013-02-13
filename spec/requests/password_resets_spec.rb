require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit login_path
    click_link "password"
    fill_in "Email", :with => user.email
    click_button "Reset Password"
    page.should have_content("Email sent")
    last_email.to.should include(user.email)
  end
  it "does not email invalid user when requesting password reset" do
    visit login_path
    click_link "password"
    fill_in "Email", :with => "nobody@example.com"
    click_button "Reset Password"
    current_path.should eq(root_path)
    page.should have_content("Email sent")
    last_email.should be_nil
  end

  it "updates the user password when confirmation matches" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
    visit password_edit_path(user.password_reset_token)
    fill_in "user_password", :with => "foobar"
    click_button "Update Password"
    page.should have_content("Password doesn't match confirmation")
    fill_in "user_password", :with => "foobar"
    fill_in "user_password_confirmation", :with => "foobar"
    click_button "Update Password"
    page.should have_content("Password has been reset")
  end

  it "reports when password token has expired" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
    visit password_edit_path(user.password_reset_token)
    page.should have_content("expired")
  end

  it "reports that token has expired when token is invalid" do
    visit password_edit_path("invalid")
    page.should have_content("expired")
  end
end
