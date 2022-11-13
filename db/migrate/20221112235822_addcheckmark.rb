class Addcheckmark < ActiveRecord::Migration[7.0]
  def change

  add_column :homeworks, :status, :boolean, default: false
  add_column :chores, :status, :boolean, default: false
  end
end
