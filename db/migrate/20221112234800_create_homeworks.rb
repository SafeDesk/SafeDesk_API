class CreateHomeworks < ActiveRecord::Migration[7.0]
  def change
    drop_table :homework

    create_table :homeworks, id: :uuid do |t|
      t.string   "task_name"
      t.string   "description"
      t.integer   "points"
      t.integer "task_priority" #number of restaurants visited
      t.datetime "date_completed" #number of restaurants visited
      t.json "homework_json" #number of restaurants visited
      t.timestamps
    end
    add_column :homeworks, :parent_id, :uuid

  end
end
