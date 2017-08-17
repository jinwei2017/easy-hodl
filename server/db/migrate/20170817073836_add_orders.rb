class AddOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :timestamp, null: false
      t.string :currency, default: "eur"
      t.float :eth, null: false
      t.float :currency_spent, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
  end
end
