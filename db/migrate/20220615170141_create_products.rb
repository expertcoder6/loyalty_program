class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :store
      t.decimal    :price
      t.string     :currency_type

      t.timestamps
    end
  end
end
