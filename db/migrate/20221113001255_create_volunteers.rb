class CreateVolunteers < ActiveRecord::Migration[7.0]
  def change
    create_table :volunteers, id: :uuid do |t|
      t.string "task_name"
      t.string "description"
      t.integer "points"
      t.json "volunteering_json"
      t.uuid "parent_id"
      t.uuid "children_id"
      t.datetime "date_completed"
      t.boolean "status", default: false

      t.timestamps
    end
    create_table :rewards, id: :uuid do |t|
      t.string "task_name"
      t.string "description"
      t.integer "points"
      t.json "volunteering_json"
      t.uuid "parent_id"
      t.uuid "children_id"
      t.datetime "date_completed"
      t.boolean "status", default: false

      t.timestamps
    end
    add_column :homeworks, :children_id, :uuid
    add_column :chores, :children_id, :uuid

  end
end
