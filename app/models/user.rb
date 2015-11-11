class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, format: /\A[A-Z0-9]+\z/i,
  					uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: /\A\S+@\S+\z/,
  					uniqueness: { case_sensitive: false }

  scope :by_name, -> { order(:name) }
  scope :non_admins, -> { by_name.where(admin: false) }

  def self.to_param
    username
  end

  def gravatar_id
  	Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email_or_username, password)
    user = find_by(email: email_or_username) || find_by(username: email_or_username)
    user && user.authenticate(password)
  end

  def first_name
    full_name = name.split(" ")
    full_name[0]
  end
end