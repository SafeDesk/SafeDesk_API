class Addrewardsfields < ActiveRecord::Migration[7.0]
  def change
    remove_column :rewards, :children_id
    add_column :rewards, :child_id, :uuid
    add_column :rewards, :unclaimed, :uuid
    add_column :rewards, :redeemed, :uuid
  end
end
