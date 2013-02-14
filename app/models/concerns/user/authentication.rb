class User
  module Authentication
    extend ActiveSupport::Concern

    included do
      validates_confirmation_of :password
      validates_presence_of :password_digest , unless: :guest?
      attr_accessible :password, :password_confirmation
      # override has_secure_password to customize validation until Rails 4.
      require 'bcrypt'
      attr_reader :password
      include ActiveModel::SecurePassword::InstanceMethodsOnActivation

      before_create { generate_token(:auth_token) }

      class_eval do

      end

    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end

    def expire_password_reset_token
      self.update_attribute :password_reset_token, nil
    end

    def update_password(userhash)
      ok = update_attributes userhash.slice(:password, :password_confirmation)
      expire_password_reset_token if ok
      ok
    end

  end
end