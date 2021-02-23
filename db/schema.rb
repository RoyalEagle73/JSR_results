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

ActiveRecord::Schema.define(version: 2021_02_22_053137) do

  create_table "scores", force: :cascade do |t|
    t.integer "semester_id", null: false
    t.integer "marks"
    t.integer "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "grade"
    t.index ["semester_id"], name: "index_scores_on_semester_id"
    t.index ["subject_id"], name: "index_scores_on_subject_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.integer "semester_number"
    t.integer "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "sgpa"
    t.index ["student_id"], name: "index_semesters_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "roll_no", limit: 15
    t.string "fathers_name", limit: 50
    t.float "CGPA"
    t.integer "college_ID", limit: 2
    t.integer "last_semester", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "class_rank", limit: 2
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "code", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "api_token"
    t.boolean "is_admin", default: false
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "scores", "semesters"
  add_foreign_key "scores", "subjects"
  add_foreign_key "semesters", "students"
end
