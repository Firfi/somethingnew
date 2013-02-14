class User < ActiveRecord::Base

  include Authentication
  include Guestable
  include Mailable

  has_many :notes, :dependent => :delete_all
  has_many :tags, :through => :notes

  attr_accessible :username, :email

  validates_presence_of :username, :email, unless: :guest?
  validates_uniqueness_of :email, :username, allow_blank: true

  scope :awaiting_activation, :conditions => 'password_confirm_token is not null'
  scope :awaiting_reactivation, :conditions => 'password_reset_token is not null'




end
