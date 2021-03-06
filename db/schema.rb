# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170331100144) do

  create_table "appointments", force: :cascade do |t|
    t.date     "starts"
    t.text     "note"
    t.integer  "calendar_id"
    t.integer  "person_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "ends"
    t.integer  "user_id"
    t.boolean  "credit"
  end

  add_index "appointments", ["calendar_id"], name: "index_appointments_on_calendar_id"
  add_index "appointments", ["person_id"], name: "index_appointments_on_person_id"
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id"

  create_table "calendars", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "max_simultaneous"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "days_per_credit"
    t.integer  "start_end_day"
    t.integer  "min_days"
    t.boolean  "no_credit_day"
    t.string   "watchers"
    t.boolean  "active"
    t.time     "start_time"
    t.time     "end_time"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "email"
    t.string   "phone"
    t.integer  "user_id"
    t.boolean  "active",     default: true
  end

  add_index "people", ["group_id"], name: "index_people_on_group_id"
  add_index "people", ["user_id"], name: "index_people_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
