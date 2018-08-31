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

ActiveRecord::Schema.define(version: 20161223043213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hunters", force: :cascade do |t|
    t.string   "profile_id"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "started_hunting"
    t.datetime "last_scanned"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "team"
    t.string   "reset_token"
  end

  create_table "profile_records", force: :cascade do |t|
    t.string   "title"
    t.integer  "title_progress"
    t.bigint   "points"
    t.bigint   "gold"
    t.integer  "horn_calls"
    t.integer  "breeds_caught"
    t.integer  "breeds_total"
    t.integer  "event_breeds_caught"
    t.integer  "event_breeds_total"
    t.bigint   "mice_caught"
    t.string   "location"
    t.string   "region"
    t.string   "trap"
    t.string   "base"
    t.string   "charm"
    t.string   "bait_name"
    t.integer  "bait_amount"
    t.integer  "trap_power"
    t.integer  "trap_luck"
    t.string   "team"
    t.integer  "hunter_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["hunter_id"], name: "index_profile_records_on_hunter_id", using: :btree
  end

  add_foreign_key "profile_records", "hunters"
end
