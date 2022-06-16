class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :plan_type
      t.integer :user_id

      t.timestamps
    end
  end
end
