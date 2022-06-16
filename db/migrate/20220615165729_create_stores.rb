class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :admin_id
      t.string  :country_type


      t.timestamps
    end
    add_index :stores,:admin_id
  end
end
