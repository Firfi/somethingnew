require 'spec_helper'
require 'support/guest_actions'

feature "Tags autocomplete",:js => true do

  before :each do
    guest_login
    within '#new_note' do
      fill_in 'note_content', :with => "test"
      fill_in 'tag_list', :with => "banana, bangalor, bangladesh, herodotus, bravada"
      click_button "Create"
    end
  end

  after :each do
    guest_logout
  end


  scenario "user fill the one tag and obtain it autocompletion" do
    within '#new_note' do
      fill_in 'tag_list', :with => "b"
      page.assert_selector('.typeahead.dropdown-menu li', :count => 4)
      fill_in 'tag_list', :with => "br"
      page.assert_selector('.typeahead.dropdown-menu li', :count => 1)
    end
  end

  scenario "user fill two tags and obtain it autocompletion. Tags in autocompletion can't repeat filled in tags." do
    within '#new_note' do
      fill_in 'tag_list', :with => "bravada, b"
      page.assert_selector('.typeahead.dropdown-menu li', :count => 3)
      fill_in 'tag_list', :with => "bangalor, ba"
      page.assert_selector('.typeahead.dropdown-menu li', :count => 2)
    end
  end

  scenario "user submit multiple tags and see them comma-separated in new task template" do
    within '#new_note' do
      fill_in 'tag_list', :with => "bravada,bee, , , , batman,"
      fill_in 'note_content', :with => "test"
      click_button "Create"
    end
    page.assert_selector("td:contains('bravada, bee, batman')")
  end

end