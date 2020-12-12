# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_09_184024) do

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.integer "minutes"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slides", force: :cascade do |t|
    t.integer "course_id"
    t.string "content"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_slides_on_course_id"
  end

end
