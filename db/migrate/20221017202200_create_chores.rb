class CreateChores < ActiveRecord::Migration[7.0]
  def change

    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'

    create_table :chores , id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|

      t.string   "task_name"
      t.integer   "points"
      t.string "category" #number of restaurants visited
      t.string "topic" #number of restaurants visited
      t.integer "task_priority" #number of restaurants visited
      t.date "date_completed" #number of restaurants visited
      t.json "chores_json" #number of restaurants visited
      t.timestamps
    end

    create_table :parents , id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|

      t.string   "first_name"
      t.string   "last_name"
      t.string   "email"
      t.string "password" #number of restaurants visited
      t.timestamps
    end

    create_table :children , id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|

      t.string   "first_name"
      t.string   "last_name"
      t.string   "email"
      t.string "password" #number of restaurants visited
      t.uuid "parent_id"
      t.timestamps
    end

  end
end
