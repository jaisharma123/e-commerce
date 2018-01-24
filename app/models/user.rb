class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and , :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2], :authentication_keys => [:login]

  after_create :sent_registration_email

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

  # def sent_registration_email
  #   ConfirmationMailer.registration_confirmation(self).deliver_now
  # end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end


end
