class User
  module Guestable
    extend ActiveSupport::Concern

    included do
      class_eval do
        def self.new_guest
          new { |u| u.guest = true; u.confirmed = true }
        end
      end
    end




    def move_to(user)
      notes.update_all(user_id: user.id)
    end

    def guest_name
      I18n.t('user.guest.name')
    end

    def template_name
      guest ? guest_name : username
    end

  end
end