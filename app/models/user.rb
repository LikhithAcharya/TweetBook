class User < ActiveRecord::Base

    has_many :tweets, dependent: :destroy
    has_many :comments
    has_many :friendships
    has_many :friends, through: :friendships
  before_save { self.email = email.downcase }

  validates :username, presence: true,uniqueness: { case_sensitive: false },length: { minimum: 3, maximum: 25 }

 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 validates :email, presence: true, length: { maximum: 105 },uniqueness: { case_sensitive: false },format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def self.search(param)
    return User.none if param.blank?

    param.strip!
    param.downcase!
    (username_matches(param) + email_matches(param)).uniq
  end

  def self.username_matches(param)
    matches('username', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(username, param)
    where("lower(#{username}) like ?", "%#{param}%")
  end

end
