class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :user_id
      t.integer :admin_id
      t.integer :value

      t.timestamps
    end
    add_index :rewards,:admin_id
  end
end
