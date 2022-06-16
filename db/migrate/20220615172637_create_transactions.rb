class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :product_id,null: false
      t.integer :store_id,null: false
      t.integer :user_id,null: false
      t.decimal :amount
      t.integer :loyalty_point_id

      t.timestamps
    end
  end
end
