class AddAvatarToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar, :string, default: "/assets/images/fallback/ava-default-male.jpg"
  end
end
