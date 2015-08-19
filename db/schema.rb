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

ActiveRecord::Schema.define(version: 20150517025251) do

  create_table "cars", force: true do |t|
    t.integer  "start_odo"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "make"
    t.string   "model"
    t.string   "rego"
    t.string   "state"
    t.integer  "user_id"
    t.boolean  "fleet",            default: false, null: false
    t.boolean  "enable",           default: true,  null: false
    t.string   "initial_location"
  end

  add_index "cars", ["user_id"], name: "index_cars_on_user_id"

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "trips", force: true do |t|
    t.integer  "odo"
    t.integer  "last_trip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "car_id"
    t.integer  "user_id"
    t.date     "date"
    t.string   "location"
    t.boolean  "garage",     default: false, null: false
    t.boolean  "personal",   default: false, null: false
    t.integer  "distance"
  end

  add_index "trips", ["car_id"], name: "index_trips_on_car_id"

  create_table "users", force: true do |t|
    t.string   "login",               default: "",    null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "name"
    t.boolean  "is_admin",            default: false
    t.string   "remember_token"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true

end
