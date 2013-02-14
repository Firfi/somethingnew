class User
  module Mailable
    extend ActiveSupport::Concern

    included do
      after_create { send_password_confirm }
    end


    def send_password_reset
      generate_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      save!
      UserMailer.password_reset(self).deliver
    end

    def send_password_confirm
      generate_token(:password_confirm_token)
      save!
      UserMailer.password_confirm(self).deliver
    end

  end
end

