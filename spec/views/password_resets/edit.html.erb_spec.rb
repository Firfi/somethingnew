require 'spec_helper'



describe "password_resets/edit.html.erb" do
  it "shows user error messages if there is some" do
    assign(:user, stub_model(
      User,
      :errors => double(
          :full_messages => ["because", "fuck you"],
          :any? => true,
          :[] => double(:any? => false),
          :count => 2
      )
    ))
    assign(:token, "somesecuritytoken")
    render
    expect(rendered).to match("because") and match("fuck you")
  end
end