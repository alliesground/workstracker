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

ActiveRecord::Schema.define(version: 20190627014633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invitations", force: :cascade do |t|
    t.string "recipient_name"
    t.string "recipient_email"
    t.string "message"
    t.string "token"
    t.integer "inviter_id"
    t.integer "recipient_id"
    t.integer "resource_id"
    t.integer "recipient_role"
    t.integer "status", default: 0
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
    t.index ["recipient_email", "resource_id"], name: "index_invitations_on_recipient_email_and_resource_id", unique: true
    t.index ["recipient_id"], name: "index_invitations_on_recipient_id"
    t.index ["status"], name: "index_invitations_on_status"
    t.index ["token"], name: "index_invitations_on_token"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.string "token"
    t.integer "recipient_id"
    t.integer "sender_id"
    t.string "invitable_type"
    t.bigint "invitable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitable_type", "invitable_id"], name: "index_invites_on_invitable_type_and_invitable_id"
    t.index ["recipient_id"], name: "index_invites_on_recipient_id"
    t.index ["sender_id"], name: "index_invites_on_sender_id"
    t.index ["token"], name: "index_invites_on_token"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "resource_type"
    t.bigint "resource_id"
    t.index ["resource_type", "resource_id"], name: "index_memberships_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "owner_id", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.boolean "allow_password_change", default: false
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.json "tokens"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "invitations", "users", column: "inviter_id"
  add_foreign_key "invites", "users", column: "recipient_id"
  add_foreign_key "invites", "users", column: "sender_id"
  add_foreign_key "memberships", "users"
end
