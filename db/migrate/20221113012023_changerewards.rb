class Changerewards < ActiveRecord::Migration[7.0]
  def change
    remove_column :rewards, :points
    remove_column :rewards, :task_name
    remove_column :rewards, :description
    remove_column :rewards, :date_completed
    remove_column :rewards, :status
    add_column :rewards, :minutes, :datetime
  end
end
