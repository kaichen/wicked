# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 8) do

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count",  :default => 0
    t.integer  "replies_count", :default => 0
  end

  create_table "replies", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "replies_count", :default => 0
    t.integer  "hits",          :default => 0
    t.integer  "sticky"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
