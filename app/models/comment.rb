class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :micropost
	validates :user_id, presence: true
	validates :micropost_id, presence: true
	validates :content, length: {maximum: 100}
end