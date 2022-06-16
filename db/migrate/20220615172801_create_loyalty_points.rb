class CreateLoyaltyPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :loyalty_points do |t|
      t.integer :point,default: 0
      t.references :user

      t.timestamps
    end
  end
end
