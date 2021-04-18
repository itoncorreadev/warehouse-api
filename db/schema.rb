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

ActiveRecord::Schema.define(version: 20210212204217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "description"
    t.boolean  "status",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "description"
    t.boolean  "status",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "details", force: :cascade do |t|
    t.integer  "quantity"
    t.float    "unit_price"
    t.float    "total_price"
    t.text     "observation"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "request_id"
    t.index ["product_id"], name: "index_details_on_product_id", using: :btree
    t.index ["request_id"], name: "index_details_on_request_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "code",         default: "0"
    t.boolean  "product_type", default: false
    t.string   "measure",      default: "Un"
    t.integer  "min",          default: 10
    t.integer  "med",          default: 20
    t.integer  "max",          default: 30
    t.string   "location"
    t.boolean  "status",       default: true
    t.integer  "group_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["group_id"], name: "index_products_on_group_id", using: :btree
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "date",          default: '2021-04-17 23:26:01'
    t.string   "request_type"
    t.string   "description"
    t.string   "document_type", default: "NF"
    t.string   "document_code", default: "0"
    t.boolean  "status",        default: false
    t.integer  "product_id"
    t.integer  "department_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "supplier_id"
    t.integer  "user_id"
    t.index ["department_id"], name: "index_requests_on_department_id", using: :btree
    t.index ["product_id"], name: "index_requests_on_product_id", using: :btree
    t.index ["supplier_id"], name: "index_requests_on_supplier_id", using: :btree
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "description"
    t.string   "type_document"
    t.string   "document"
    t.string   "address"
    t.string   "phone"
    t.text     "comment"
    t.boolean  "status",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "done",        default: false
    t.datetime "deadline",    default: '2021-04-17 23:25:59'
    t.integer  "user_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "auth_token"
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.boolean  "allow_password_change",  default: false
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.json     "tokens"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "details", "products"
  add_foreign_key "details", "requests"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "groups"
  add_foreign_key "requests", "departments"
  add_foreign_key "requests", "products"
  add_foreign_key "requests", "suppliers"
  add_foreign_key "requests", "users"
  add_foreign_key "tasks", "users"
end
