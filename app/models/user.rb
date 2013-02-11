class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_many :notes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :name

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, :with => /\A[a-z]+[-._a-z]*\Z/i # change error message in locales too if you want change this logic

  private

  # we override the devise method find_for_authentication which normally just finds the first record based on the given conditions
  def self.find_for_authentication(conditions={})
    self.where("username = ?", conditions[:email]).limit(1).first ||
      self.where("email = ?", conditions[:email]).limit(1).first
  end

end
