class Addcol < ActiveRecord::Migration[7.0]
  def change
    add_column :chores, :parent_id, :uuid

  end
end
