class User < ActiveRecord::Base

  attr_accessor :remember_token
  # downcase all email address before saving to DB
  before_save { self.email.downcase! }

  # name must be present, length <=50
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # email must be present, length <=255, format must match email regex, must be unique, case-insensitive
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # password's length >=6
  validates :password, length: {minimum: 6}

  # add the ability to store HASH version password in DB, must have a DB column with name "password_digest"
  has_secure_password

   #returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random token
  def User.new_token()
    SecureRandom.urlsafe_base64
  end

  # remember a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
