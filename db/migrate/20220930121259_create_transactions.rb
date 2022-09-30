class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :customer_id
      t.integer :input_amount
      t.string :input_currency
      t.integer :output_amount
      t.string :output_currency

      t.timestamps
    end

    add_index :transactions, :customer_id
    add_index :transactions, [:customer_id, :id], unique: true
  end
end
