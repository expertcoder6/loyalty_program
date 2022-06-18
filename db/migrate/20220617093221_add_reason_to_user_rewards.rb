class AddReasonToUserRewards < ActiveRecord::Migration[6.0]
  def change
    add_column :user_rewards, :reason, :string
  end
end
