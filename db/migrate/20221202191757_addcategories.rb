class Addcategories < ActiveRecord::Migration[7.0]
  def change
    add_column :chores, :category, :string
    add_column :volunteers, :category, :string
    add_column :homeworks, :category, :string

  end
end
