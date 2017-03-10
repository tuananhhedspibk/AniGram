class User < ApplicationRecord
	attr_accessor :remember_token	# create accessible attribute remember_token
	before_save {self.email.downcase!}
	validates :name, presence: true, length: {maximum: 50}
	VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
					  format: {with: VALIDATE_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}
	has_secure_password
	mount_uploader :avatar, AvatarUploader
	validates :password, presence: true, length: {minimum: 6}, allow_nil: true
	validate :avatar_size
	has_many :microposts, dependent: :destroy
	has_many :active_relationships, class_name: "Relationship",
									foreign_key: "follower_id",
									dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship",
									foreign_key: "followed_id",
									dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	has_many :likes , dependent: :destroy
	has_many :comments, dependent: :destroy

	# Returns the hash digest of the given string.
	def self.digest string
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def self.new_token
		SecureRandom.urlsafe_base64
	end

	# Search users
	def self.search name
		User.where("name like ?", "%#{name}%")
	end

	def already_like?(micropost)
		micropost.likes.find_by(user_id: self.id) != nil
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated? remember_token
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Defines a proto-feed.
	# See "Following users" for the full implementation.
	def feed
		following_ids = "SELECT followed_id FROM relationships
						WHERE follower_id = :user_id"
		Micropost.where("user_id IN (#{following_ids}) 
						OR user_id = :user_id", user_id: id)
	end

	# Follows a user
	def follow other_user
		active_relationships.create(followed_id: other_user.id)
	end

	# Unfollow a user
	def unfollow other_user
		following.delete(other_user)
	end

	# Return true if the current user is following the other user
	def following? other_user
		following.include?(other_user)
	end

	private
		def avatar_size
			if avatar.size > 5.megabytes
				error.add(:avatar, "should be less than 5MB")
			end
		end
end