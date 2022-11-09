class Adddatetimefieldchores < ActiveRecord::Migration[7.0]
  def change
    remove_column :chores, :date_completed
    add_column :chores, :date_completed, :datetime
  end
end
