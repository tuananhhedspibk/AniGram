class CreateNotifications < ActiveRecord::Migration[5.0]
	def change
		create_table :notifications do |t|
			t.references :user, foreign_key: true
			t.references :notified_by, index: true
			t.references :micropost, foreign_key: true
			t.references :comment, foreign_key: true
			t.references :like, foreign_key: true
			t.string :notifi_type
			t.boolean :read, default: false

			t.timestamps
		end
		add_foreign_key :notifications, :users, column: :notified_by_id
	end
end
