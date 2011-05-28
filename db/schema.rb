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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110528024723) do

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.text     "description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.string   "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "melee",                :limit => 8, :default => 0
    t.integer  "ranged",               :limit => 8, :default => 0
    t.integer  "defense",              :limit => 8, :default => 0
    t.integer  "agility",              :limit => 8, :default => 0
    t.integer  "cunning",              :limit => 8, :default => 0
    t.integer  "req_research",         :limit => 8, :default => 0
    t.integer  "price",                :limit => 8, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["name"], :name => "index_items_on_name", :unique => true
  add_index "items", ["type"], :name => "index_items_on_type", :unique => true

  create_table "missions", :force => true do |t|
    t.string   "name",                              :null => false
    t.string   "subtitle"
    t.text     "description"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "req_level",            :limit => 8
    t.integer  "req_energy",           :limit => 8
    t.integer  "xp_min",               :limit => 8
    t.integer  "xp_max",               :limit => 8
    t.integer  "damage",               :limit => 8
    t.boolean  "check_melee"
    t.integer  "min_melee",            :limit => 8
    t.integer  "max_melee",            :limit => 8
    t.boolean  "check_ranged"
    t.integer  "min_ranged",           :limit => 8
    t.integer  "max_ranged",           :limit => 8
    t.boolean  "check_defense"
    t.integer  "min_defense",          :limit => 8
    t.integer  "max_defense",          :limit => 8
    t.boolean  "check_agility"
    t.integer  "min_agility",          :limit => 8
    t.integer  "max_agility",          :limit => 8
    t.boolean  "check_cunning"
    t.integer  "min_cunning",          :limit => 8
    t.integer  "max_cunning",          :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "missions", ["name"], :name => "index_missions_on_name", :unique => true

  create_table "owned_items", :force => true do |t|
    t.integer  "user_id",                                          :null => false
    t.integer  "item_id",                                          :null => false
    t.string   "nickname"
    t.integer  "melee",                :limit => 8, :default => 0
    t.integer  "ranged",               :limit => 8, :default => 0
    t.integer  "defense",              :limit => 8, :default => 0
    t.integer  "agility",              :limit => 8, :default => 0
    t.integer  "cunning",              :limit => 8, :default => 0
    t.integer  "price_bonus",          :limit => 8, :default => 0
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "rarity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "owned_items", ["item_id"], :name => "index_owned_items_on_item_id"
  add_index "owned_items", ["user_id"], :name => "index_owned_items_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",                                                 :null => false
    t.string   "display_name"
    t.integer  "xp",                     :limit => 8,   :default => 0
    t.integer  "health",                 :limit => 8,   :default => 0
    t.integer  "energy",                 :limit => 8,   :default => 0
    t.integer  "credits",                :limit => 8,   :default => 0
    t.integer  "melee",                  :limit => 8,   :default => 5
    t.integer  "ranged",                 :limit => 8,   :default => 5
    t.integer  "defense",                :limit => 8,   :default => 5
    t.integer  "agility",                :limit => 8,   :default => 5
    t.integer  "cunning",                :limit => 8,   :default => 5
    t.integer  "available_points",                      :default => 0
    t.boolean  "admin",                                 :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
