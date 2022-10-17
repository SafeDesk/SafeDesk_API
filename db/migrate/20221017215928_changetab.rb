class Changetab < ActiveRecord::Migration[7.0]
  def change
    drop_table :chores

    create_table :chores , id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|

      t.string   "task_name"
      t.string   "description"
      t.integer   "points"
      t.integer "task_priority" #number of restaurants visited
      t.date "date_completed" #number of restaurants visited
      t.json "chores_json" #number of restaurants visited
      t.timestamps
    end
  end
end
