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

ActiveRecord::Schema.define(version: 20140720143938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accountants", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name",       null: false
    t.string   "shortname",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accountants", ["shortname"], name: "index_accountants_on_shortname", unique: true, using: :btree

  create_table "clients", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name",                      null: false
    t.string   "shortname",                 null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "curator_id"
    t.boolean  "is_active",  default: true
  end

  add_index "clients", ["shortname"], name: "index_clients_on_shortname", unique: true, using: :btree

  create_table "curators", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name",                       null: false
    t.string   "shortname",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",   default: true
    t.binary   "template_id"
  end

  add_index "curators", ["shortname"], name: "index_curators_on_shortname", unique: true, using: :btree

  create_table "curatorships", id: false, force: true do |t|
    t.integer  "user_id",                    null: false
    t.uuid     "curator_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",   default: false
  end

  create_table "memberships", id: false, force: true do |t|
    t.integer  "user_id",                    null: false
    t.uuid     "client_id",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",   default: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
