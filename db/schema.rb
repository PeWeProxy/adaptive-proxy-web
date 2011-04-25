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

ActiveRecord::Schema.define(:version => 0) do

  create_table "access_logs", :force => true do |t|
    t.string   "userid",       :limit => 32
    t.datetime "timestamp"
    t.integer  "time_on_page"
    t.string   "page_id",      :limit => 40
    t.integer  "scroll_count"
    t.integer  "copy_count"
    t.string   "referer",      :limit => 4000
    t.string   "ip",           :limit => 50
  end

  add_index "access_logs", ["page_id"], :name => "index_access_logs_on_page_id"
  add_index "access_logs", ["userid", "timestamp"], :name => "index_access_logs_on_userid_and_timestamp"

  create_table "broken_pages", :force => true do |t|
    t.string   "url",       :limit => 4000, :null => false
    t.string   "uid",       :limit => 32,   :null => false
    t.datetime "timestamp",                 :null => false
  end

  create_table "emails", :force => true do |t|
    t.string "email"
  end

  create_table "pages", :force => true do |t|
    t.string   "url",            :limit => 4000
    t.string   "checksum",       :limit => 32
    t.integer  "content_length"
    t.string   "keywords",       :limit => 4000
    t.datetime "failed_at"
    t.string   "failure_reason", :limit => 1000
    t.integer  "processed",      :limit => 1
  end

  add_index "pages", ["checksum"], :name => "index_pages_on_checksum"
  add_index "pages", ["url", "checksum"], :name => "index_pages_on_url_and_checksum", :length => {"url"=>255, "checksum"=>nil}

  create_table "pages_terms", :force => true do |t|
    t.string   "page_id",    :limit => 40
    t.integer  "term_id"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source",     :limit => 20
    t.integer  "active",     :limit => 1,  :default => 1, :null => false
  end

  create_table "stored_apuids", :force => true do |t|
    t.string   "identifier"
    t.string   "uid"
    t.datetime "valid_until"
  end

  create_table "terms", :force => true do |t|
    t.string "label"
    t.string "term_type"
  end

end
