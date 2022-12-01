class RenameColumnRewards < ActiveRecord::Migration[7.0]
  def change
    remove_column :rewards, :unclaimed
    add_column :rewards, :unclaimed, :integer
    remove_column :rewards, :redeemed
    add_column :rewards, :redeemed, :integer
  end
end
