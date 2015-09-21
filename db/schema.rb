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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140220132054) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "apisettings", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "api_key"
  end

  create_table "author_books", :force => true do |t|
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "title"
    t.string   "author_name"
    t.string   "genres"
    t.string   "status"
    t.string   "name"
    t.string   "email"
    t.string   "payment_status"
    t.string   "rb_price"
    t.string   "pb_price"
    t.string   "links_retailers"
    t.string   "flexible"
    t.string   "genre_price"
    t.date     "preferred_end_date"
    t.date     "preferred_start_date"
    t.string   "template"
    t.text     "additional_information"
    t.string   "amazon_link"
    t.string   "amazon_star_rating"
  end

  create_table "key_mandrills", :force => true do |t|
    t.string   "key"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mandrill_settings", :force => true do |t|
    t.string   "subject"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "from_email"
    t.string   "from_name"
    t.string   "apr_subject"
    t.string   "rem_subject"
    t.string   "apr_tempate"
    t.string   "rem_template"
  end

  create_table "mclists", :force => true do |t|
    t.string   "key"
    t.string   "list_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "email"
    t.integer  "grouping_id"
    t.string   "list_name"
    t.string   "grouping_name"
  end

  create_table "payments", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "card_numbre"
    t.string   "card_code"
    t.string   "card_exp_date"
    t.integer  "author_book_id"
    t.string   "token"
    t.string   "charge_id"
  end

  create_table "pricings", :force => true do |t|
    t.integer  "mclist_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "group_name"
    t.string   "group_id"
    t.string   "tier_1"
    t.string   "tier_2"
    t.string   "tier_3"
  end

  create_table "retailers", :force => true do |t|
    t.integer  "author_book_id"
    t.string   "retailer_link"
    t.string   "retailer_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "scheduleings", :force => true do |t|
    t.date     "schedule_date"
    t.integer  "author_book_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "stripeconnections", :force => true do |t|
    t.string   "access_token"
    t.string   "email"
    t.string   "ref_token"
    t.string   "token_type"
    t.string   "stripe_user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "user_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "wordpresses", :force => true do |t|
    t.string   "path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "xmlrpcs", :force => true do |t|
    t.string   "path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
