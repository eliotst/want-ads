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

ActiveRecord::Schema.define(version: 20171012103819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified"
    t.bigint "verification_token_id"
    t.bigint "conversation_id"
    t.index ["conversation_id"], name: "index_interests_on_conversation_id"
    t.index ["person_id"], name: "index_interests_on_person_id"
    t.index ["role_id"], name: "index_interests_on_role_id"
    t.index ["verification_token_id"], name: "index_interests_on_verification_token_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "conversation_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["person_id"], name: "index_messages_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_hash"
    t.string "password_salt"
    t.integer "user_type"
  end

  create_table "person_roles", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_person_roles_on_person_id"
    t.index ["role_id"], name: "index_person_roles_on_role_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.index ["person_id"], name: "index_projects_on_person_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "conversation_id"
    t.integer "number_of_people"
    t.integer "role_type"
    t.index ["conversation_id"], name: "index_roles_on_conversation_id"
    t.index ["project_id"], name: "index_roles_on_project_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "status"
    t.bigint "project_id"
    t.bigint "person_id"
    t.bigint "role_id"
    t.bigint "conversation_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.index ["conversation_id"], name: "index_tasks_on_conversation_id"
    t.index ["parent_id"], name: "index_tasks_on_parent_id"
    t.index ["person_id"], name: "index_tasks_on_person_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["role_id"], name: "index_tasks_on_role_id"
  end

  create_table "verification_tokens", force: :cascade do |t|
    t.string "token"
    t.bigint "person_id"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_verification_tokens_on_person_id"
  end

  add_foreign_key "interests", "conversations"
  add_foreign_key "interests", "people"
  add_foreign_key "interests", "roles"
  add_foreign_key "interests", "verification_tokens"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "people"
  add_foreign_key "person_roles", "people"
  add_foreign_key "person_roles", "roles"
  add_foreign_key "projects", "people"
  add_foreign_key "roles", "conversations"
  add_foreign_key "roles", "projects"
  add_foreign_key "tasks", "conversations"
  add_foreign_key "tasks", "people"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "roles"
  add_foreign_key "tasks", "tasks", column: "parent_id"
  add_foreign_key "verification_tokens", "people"
end
