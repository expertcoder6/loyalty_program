class CreateUserRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :user_rewards do |t|
      t.references :reward
      t.references :user
      t.references :product
      t.integer    :store_id

      t.timestamps
    end
  end
end
