require 'spec_helper'

describe "password_resets/new.html.erb" do
  it "prompts for email" do
    render
    expect(rendered).to match("Email")
  end
  it "displays 'Reset Password' message" do
    render
    expect(rendered).to match(t('user.password.reset.button'))
  end
end
