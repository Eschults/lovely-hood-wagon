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

ActiveRecord::Schema.define(version: 20141223110748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "bookings", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "accepted"
    t.integer  "offer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_hour"
    t.time     "end_hour"
  end

  add_index "bookings", ["offer_id"], name: "index_bookings_on_offer_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["user1_id"], name: "index_conversations_on_user1_id", using: :btree
  add_index "conversations", ["user2_id"], name: "index_conversations_on_user2_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "writer_id"
    t.datetime "read_at"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["writer_id"], name: "index_messages_on_writer_id", using: :btree

  create_table "offers", force: true do |t|
    t.string   "nature"
    t.string   "description"
    t.integer  "hourly_price"
    t.integer  "daily_price"
    t.integer  "weekly_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "price"
    t.string   "type_of_offer"
    t.boolean  "published"
    t.integer  "guarantee"
  end

  add_index "offers", ["user_id"], name: "index_offers_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.text     "comment"
    t.integer  "communication_rating"
    t.integer  "punctuality_rating"
    t.integer  "respect_rating"
    t.boolean  "recommendation"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["booking_id"], name: "index_reviews_on_booking_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                       default: "", null: false
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "picture"
    t.string   "name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "birthday"
    t.string   "phone"
    t.text     "description"
    t.string   "street_number"
    t.string   "street_name"
    t.string   "zip_code"
    t.string   "city"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "identity_verified"
    t.boolean  "address_verified"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "identity_proof_file_name"
    t.string   "identity_proof_content_type"
    t.integer  "identity_proof_file_size"
    t.datetime "identity_proof_updated_at"
    t.string   "address_proof_file_name"
    t.string   "address_proof_content_type"
    t.integer  "address_proof_file_size"
    t.datetime "address_proof_updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
