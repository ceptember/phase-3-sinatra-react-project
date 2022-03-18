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

ActiveRecord::Schema.define(version: 2022_03_16_195821) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "more_info"
  end

  create_table "parks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.string "city"
    t.string "state"
    t.float "lat"
    t.float "long"
  end

  create_table "parks_activities", force: :cascade do |t|
    t.integer "park_id"
    t.integer "activity_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "park_id"
    t.integer "user_id"
    t.string "review_text"
    t.integer "likes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "user_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
