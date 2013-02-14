def guest_login
  visit "/"
  click_button "Try it"
end
def guest_logout
  visit "/logout"
end
