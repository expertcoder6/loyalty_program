class AddBirthdateDateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users,:birthdate_date,:datetime
  end
end
