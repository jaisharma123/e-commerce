class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  ROLES = %w[admin guest].freeze

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def admin?
    self.role == "admin"
  end

  def guest?
    self.role == "guest"
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.mobile_no || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(mobile_no) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:mobile_no) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end


end
