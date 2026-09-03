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

ActiveRecord::Schema[8.1].define(version: 2026_09_03_170856) do
  create_table "activities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.string "vibe"
  end

  create_table "plan_activities", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.string "notes"
    t.integer "plan_id", null: false
    t.integer "rating"
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_plan_activities_on_activity_id"
    t.index ["plan_id"], name: "index_plan_activities_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.float "budget"
    t.datetime "created_at", null: false
    t.string "location"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "vibe"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "plan_activities", "activities"
  add_foreign_key "plan_activities", "plans"
  add_foreign_key "plans", "users"
end
