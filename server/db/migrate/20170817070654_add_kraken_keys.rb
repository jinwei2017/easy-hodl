class AddKrakenKeys < ActiveRecord::Migration
  def change
    add_column :users, :kraken_key, :string
    add_column :users, :kraken_secret, :string
  end
end
