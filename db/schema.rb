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

ActiveRecord::Schema.define(version: 20160201202011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "excercises", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "reverse_weight", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.date     "date"
    t.integer  "reps"
    t.decimal  "weight"
    t.integer  "time"
    t.integer  "serie_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "results", ["serie_id"], name: "index_results_on_serie_id", using: :btree
  add_index "results", ["user_id"], name: "index_results_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "series", force: :cascade do |t|
    t.text     "note"
    t.integer  "order"
    t.integer  "series"
    t.integer  "slot_id"
    t.integer  "excercise_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "series", ["excercise_id"], name: "index_series_on_excercise_id", using: :btree
  add_index "series", ["slot_id"], name: "index_series_on_slot_id", using: :btree

  create_table "slots", force: :cascade do |t|
    t.integer  "order"
    t.text     "note"
    t.integer  "slotable_id"
    t.string   "slotable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "slots", ["slotable_type", "slotable_id"], name: "index_slots_on_slotable_type_and_slotable_id", using: :btree

  create_table "templates", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_prototypes", force: :cascade do |t|
    t.integer  "day"
    t.time     "from"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "training_prototypes", ["group_id"], name: "index_training_prototypes_on_group_id", using: :btree

  create_table "training_results", force: :cascade do |t|
    t.integer  "time"
    t.integer  "rate"
    t.integer  "calories"
    t.integer  "training_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.date     "date"
    t.time     "from"
    t.date     "from_prototype_at"
    t.integer  "training_prototype_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "trainings", ["training_prototype_id"], name: "index_trainings_on_training_prototype_id", using: :btree

  create_table "trainings_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "training_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "group_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
