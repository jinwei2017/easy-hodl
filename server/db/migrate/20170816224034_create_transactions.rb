class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :timestamp, null: false
      t.string :transaction_id, null: false
      t.string :currency, null: false
      t.integer :amount, null: false
      t.integer :saved, null: false
      t.string :description, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
    add_index :transactions, :transaction_id, unique: true
  end
end
