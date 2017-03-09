class AddFkMicropostIdToLikes < ActiveRecord::Migration[5.0]
	def change
		add_reference :likes, :micropost, foreign_key: true
	end
end