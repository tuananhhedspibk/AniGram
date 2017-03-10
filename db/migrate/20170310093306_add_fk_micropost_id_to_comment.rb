class AddFkMicropostIdToComment < ActiveRecord::Migration[5.0]
	def change
		add_reference :comments, :micropost, foreign_key: true
	end
end	