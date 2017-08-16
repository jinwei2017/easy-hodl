class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :truelayer_access_token, null: false
      t.string :truelayer_refresh_token, null: false
      t.string :truelayer_id, null: false
    end
    add_index :users, :truelayer_id, unique: true
  end
end
