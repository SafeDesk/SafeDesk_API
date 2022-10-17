# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_17_220905) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "children", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.uuid "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chores", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "task_name"
    t.string "description"
    t.integer "points"
    t.integer "task_priority"
    t.date "date_completed"
    t.json "chores_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "parent_id"
  end

  create_table "parents", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
