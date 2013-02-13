class User < ActiveRecord::Base

  has_many :notes

  attr_accessible :username, :email, :password, :password_confirmation

  validates_presence_of :username, :email, :password_digest, unless: :guest?
  validates_uniqueness_of :email, :username, allow_blank: true
  validates_confirmation_of :password

  scope :awaiting_activation, :conditions => "password_reset_token is not null"

  # override has_secure_password to customize validation until Rails 4.
  require 'bcrypt'
  attr_reader :password
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation

  def self.new_guest
    new { |u| u.guest = true; u.confirmed = true }
  end

  def name
    guest ? "Guest" : username
  end

  before_create { generate_token(:auth_token) }
  after_create { send_password_confirm }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
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

  def expire_password_reset_token
    self.update_attribute :password_reset_token, nil
  end

  def update_password(userhash)
    ok = update_attributes userhash.slice(:password, :password_confirmation)
    expire_password_reset_token if ok
    ok
  end

end
