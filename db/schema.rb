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

ActiveRecord::Schema.define(version: 20170602010821) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address",          limit: 255
    t.integer  "addressable_id",   limit: 4
    t.string   "addressable_type", limit: 255
    t.string   "email",            limit: 255
    t.string   "fname",            limit: 255
    t.string   "lname",            limit: 255
    t.string   "doc_type",         limit: 255
    t.string   "doc_number",       limit: 255
    t.string   "company",          limit: 255
    t.string   "zip_code",         limit: 255
    t.string   "city",             limit: 255
    t.string   "mobile",           limit: 255
    t.integer  "zone_id",          limit: 4
    t.integer  "position",         limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  add_index "addresses", ["zone_id"], name: "index_addresses_on_zone_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",        null: false
    t.string   "profile",                limit: 255, default: "regular", null: false
    t.string   "encrypted_password",     limit: 255, default: "",        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "shape",              limit: 4,     default: 0
    t.integer  "status",             limit: 4,     default: 0
    t.string   "title",              limit: 255
    t.string   "subtitle",           limit: 255
    t.string   "description",        limit: 255
    t.text     "text",               limit: 65535
    t.string   "link",               limit: 255
    t.string   "link_title",         limit: 255
    t.boolean  "link_external",                    default: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "position",           limit: 4
    t.string   "slug",               limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "ancestry",   limit: 255
    t.boolean  "fixed",                  default: false
    t.string   "slug",       limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "kind",             limit: 4,     default: 0
    t.boolean  "read",                           default: false
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "company",          limit: 255
    t.string   "subject",          limit: 255
    t.text     "message",          limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "contactable_id",   limit: 4
    t.string   "contactable_type", limit: 255
  end

  add_index "contacts", ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.integer  "imageable_id",      limit: 4
    t.string   "imageable_type",    limit: 255
    t.string   "item_file_name",    limit: 255
    t.string   "item_content_type", limit: 255
    t.integer  "item_file_size",    limit: 4
    t.datetime "item_updated_at"
    t.integer  "position",          limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "images", ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree

  create_table "payment_products", force: :cascade do |t|
    t.integer  "payment_id",    limit: 4
    t.integer  "product_id",    limit: 4
    t.integer  "quantity",      limit: 4
    t.decimal  "price",                     precision: 8, scale: 2
    t.string   "title",         limit: 255
    t.string   "key_code",      limit: 255
    t.string   "brand",         limit: 255
    t.integer  "category_id",   limit: 4
    t.integer  "currency",      limit: 4,                           default: 0
    t.string   "description",   limit: 255
    t.string   "external_link", limit: 255
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  add_index "payment_products", ["category_id"], name: "index_payment_products_on_category_id", using: :btree
  add_index "payment_products", ["payment_id"], name: "index_payment_products_on_payment_id", using: :btree
  add_index "payment_products", ["product_id"], name: "index_payment_products_on_product_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id",                limit: 4
    t.decimal  "transaction_amount",                   precision: 8, scale: 2
    t.integer  "installments",           limit: 4,                             default: 1
    t.decimal  "shipment_cost",                        precision: 8, scale: 2
    t.string   "payment_method_id",      limit: 255
    t.string   "token",                  limit: 255
    t.text     "additional_info",        limit: 65535
    t.text     "mercadopago_payment",    limit: 65535
    t.integer  "mercadopago_payment_id", limit: 8
    t.string   "status",                 limit: 255
    t.string   "status_detail",          limit: 255
    t.integer  "zone_id",                limit: 4
    t.boolean  "save_address",                                                 default: false
    t.boolean  "save_card",                                                    default: false
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.decimal  "dolar",                                precision: 8, scale: 2
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree
  add_index "payments", ["zone_id"], name: "index_payments_on_zone_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "title",                        limit: 255
    t.integer  "status",                       limit: 4,                             default: 0
    t.integer  "special",                      limit: 4,                             default: 0
    t.string   "key_code",                     limit: 255
    t.string   "brand",                        limit: 255
    t.integer  "category_id",                  limit: 4
    t.integer  "stock",                        limit: 4
    t.decimal  "price",                                      precision: 8, scale: 2
    t.integer  "currency",                     limit: 4,                             default: 0
    t.integer  "width_mm",                     limit: 4
    t.integer  "height_mm",                    limit: 4
    t.integer  "depth_mm",                     limit: 4
    t.string   "description",                  limit: 255
    t.text     "characteristics",              limit: 65535
    t.text     "data_sheet",                   limit: 65535
    t.text     "information",                  limit: 65535
    t.string   "external_link",                limit: 255
    t.string   "slug",                         limit: 255
    t.datetime "created_at",                                                                     null: false
    t.datetime "updated_at",                                                                     null: false
    t.string   "data_sheet_file_file_name",    limit: 255
    t.string   "data_sheet_file_content_type", limit: 255
    t.integer  "data_sheet_file_file_size",    limit: 4
    t.datetime "data_sheet_file_updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "score",           limit: 4
    t.integer  "reviewer_id",     limit: 4
    t.string   "reviewer_type",   limit: 255
    t.integer  "reviewable_id",   limit: 4
    t.string   "reviewable_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "reviews", ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id", using: :btree
  add_index "reviews", ["reviewer_type", "reviewer_id"], name: "index_reviews_on_reviewer_type_and_reviewer_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fname",                  limit: 255
    t.string   "lname",                  limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "customer_id",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "websites", force: :cascade do |t|
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "mobile",     limit: 255
    t.string   "email",      limit: 255
    t.string   "facebook",   limit: 255
    t.string   "twitter",    limit: 255
    t.string   "google",     limit: 255
    t.string   "linkedin",   limit: 255
    t.string   "youtube",    limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "dolar",                  precision: 8, scale: 2
  end

  create_table "works", force: :cascade do |t|
    t.string   "title",                        limit: 255
    t.integer  "status",                       limit: 4,     default: 0
    t.integer  "special",                      limit: 4,     default: 0
    t.integer  "category_id",                  limit: 4
    t.string   "description",                  limit: 255
    t.text     "characteristics",              limit: 65535
    t.text     "data_sheet",                   limit: 65535
    t.text     "information",                  limit: 65535
    t.string   "external_link",                limit: 255
    t.string   "slug",                         limit: 255
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "data_sheet_file_file_name",    limit: 255
    t.string   "data_sheet_file_content_type", limit: 255
    t.integer  "data_sheet_file_file_size",    limit: 4
    t.datetime "data_sheet_file_updated_at"
  end

  add_index "works", ["category_id"], name: "index_works_on_category_id", using: :btree
  add_index "works", ["slug"], name: "index_works_on_slug", unique: true, using: :btree

  create_table "zones", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "ancestry",      limit: 255
    t.decimal  "shipment_cost",             precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_foreign_key "addresses", "zones"
  add_foreign_key "payment_products", "categories"
  add_foreign_key "payment_products", "payments"
  add_foreign_key "payment_products", "products"
  add_foreign_key "payments", "users"
  add_foreign_key "payments", "zones"
  add_foreign_key "products", "categories"
  add_foreign_key "taggings", "tags"
  add_foreign_key "works", "categories"
end
