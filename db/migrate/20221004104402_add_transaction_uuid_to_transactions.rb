class AddTransactionUuidToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :uuid, :uuid, default: "gen_random_uuid()"
    add_index :transactions, :uuid, unique: true
  end
end
