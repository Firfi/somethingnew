require 'spec_helper'
require 'support/guest_actions'

feature "Guest user" do

  def create_note
    within '#new_note' do
      fill_in 'note_content', :with => "test"
      click_button "Create"
    end
  end

  user_message = lambda { |name| t('user.logged.in.as', :name => name) }

  guest_message = user_message.call(t('user.guest.name'))

  scenario "User goes to Try", :js => true do

    guest_login

    expect(page).to have_text(t('note.notes')) and have_text(guest_message)
    expect(find('#notes')).not_to have_selector('.note')

    guest_logout

  end

  scenario "User goes to try and create some note", :js => true do

    guest_login

    create_note
    expect(find('#notes')).to have_selector('.note')

    guest_logout

  end

  scenario "User goest to try, create pair of notes and then decide to register.
            After successful registration he login, goes to notes page and see his old notes under new user" do

    guest_login

    notes_num = rand(1..20)
    notes_num.times { create_note }

    click_link t("user.guest.become_member")

    email = "test@example.com"
    password = "secret"
    username = "Bob"

    fill_in 'user_email', :with => email
    fill_in 'user_username', :with => username
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => password

    click_button "Sign Up"

    expect(page).to have_content(t('user.created.check_email'))

    password_link = last_email.body.raw_source.split("\n").find { |s| s.index('password_confirms') }

    visit password_link

    expect(page).to have_content(t('user.email.confirmed'))

    fill_in 'email', :with => email
    fill_in 'password', :with => password

    click_button "Log In"

    expect(page).not_to have_content(guest_message)
    expect(page).to have_content(user_message.call(username))

    page.assert_selector('.note', :count => notes_num)

  end

end