class AddHw < ActiveRecord::Migration[7.0]
  def change

    create_table :homework , id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|

      t.string   "task_name"
      t.string   "description"
      t.integer   "points"
      t.integer "task_priority" #number of restaurants visited
      t.datetime "date_completed" #number of restaurants visited
      t.json "homework_json" #number of restaurants visited
      t.timestamps
    end
    add_column :homework, :parent_id, :uuid

  end
end
