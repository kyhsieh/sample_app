class User < ActiveRecord::Base
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
end
