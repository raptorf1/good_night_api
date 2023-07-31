# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_07_31_083524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follow_associations", force: :cascade do |t|
    t.bigint "requested_by_user_id"
    t.bigint "user_to_follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requested_by_user_id"], name: "index_follow_associations_on_requested_by_user_id"
    t.index ["user_to_follow_id"], name: "index_follow_associations_on_user_to_follow_id"
  end

  create_table "sleep_wake_times", force: :cascade do |t|
    t.datetime "sleep"
    t.datetime "wake"
    t.float "difference"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sleep_wake_times_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "follow_associations", "users", column: "requested_by_user_id"
  add_foreign_key "follow_associations", "users", column: "user_to_follow_id"
  add_foreign_key "sleep_wake_times", "users"
end
