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

ActiveRecord::Schema.define(version: 20150215011655) do

  create_table "authors", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "full_name",  limit: 255
    t.text     "bio",        limit: 65535
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "image",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "category_title_list_memberships", force: :cascade do |t|
    t.integer  "title_list_id", limit: 4
    t.integer  "category_id",   limit: 4
    t.integer  "position",      limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "category_title_list_memberships", ["category_id"], name: "index_category_title_list_memberships_on_category_id", using: :btree
  add_index "category_title_list_memberships", ["title_list_id"], name: "index_category_title_list_memberships_on_title_list_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "contributions", force: :cascade do |t|
    t.integer  "author_id",  limit: 4
    t.integer  "title_id",   limit: 4
    t.string   "what",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "contributions", ["author_id", "title_id"], name: "index_contributions_on_author_id_and_title_id", using: :btree
  add_index "contributions", ["author_id"], name: "index_contributions_on_author_id", using: :btree
  add_index "contributions", ["title_id"], name: "index_contributions_on_title_id", using: :btree

  create_table "copies", force: :cascade do |t|
    t.integer  "edition_id",           limit: 4
    t.integer  "cost_in_cents",        limit: 4
    t.integer  "price_in_cents",       limit: 4
    t.text     "notes",                limit: 65535
    t.integer  "owner_id",             limit: 4
    t.boolean  "is_used",              limit: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.datetime "inventoried_when"
    t.datetime "deinventoried_when"
    t.string   "status",               limit: 255
    t.integer  "invoice_line_item_id", limit: 4
  end

  add_index "copies", ["edition_id"], name: "index_copies_on_edition_id", using: :btree
  add_index "copies", ["invoice_line_item_id"], name: "index_copies_on_invoice_line_item_id", using: :btree
  add_index "copies", ["owner_id"], name: "index_copies_on_owner_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "distributors", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "our_account_number", limit: 255
    t.text     "notes",              limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "editions", force: :cascade do |t|
    t.string   "isbn13",              limit: 255
    t.string   "isbn10",              limit: 255
    t.integer  "year_of_publication", limit: 4
    t.string   "format",              limit: 255
    t.boolean  "in_print",            limit: 1
    t.text     "notes",               limit: 65535
    t.integer  "title_id",            limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "cover",               limit: 255
    t.integer  "list_price_cents",    limit: 4
    t.integer  "publisher_id",        limit: 4
    t.text     "number",              limit: 65535
  end

  add_index "editions", ["publisher_id"], name: "index_editions_on_publisher_id", using: :btree
  add_index "editions", ["title_id"], name: "index_editions_on_title_id", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "inventory_copy_confirmations", force: :cascade do |t|
    t.integer  "inventory_id", limit: 4
    t.integer  "copy_id",      limit: 4
    t.boolean  "status",       limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "inventory_copy_confirmations", ["copy_id"], name: "index_inventory_copy_confirmations_on_copy_id", using: :btree
  add_index "inventory_copy_confirmations", ["inventory_id"], name: "index_inventory_copy_confirmations_on_inventory_id", using: :btree

  create_table "invoice_line_items", force: :cascade do |t|
    t.integer  "quantity",                    limit: 4
    t.integer  "edition_id",                  limit: 4
    t.integer  "invoice_id",                  limit: 4
    t.integer  "purchase_order_line_item_id", limit: 4
    t.boolean  "is_transfer",                 limit: 1
    t.float    "discount",                    limit: 24
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "price_in_cents",              limit: 4
    t.integer  "ext_in_cents",                limit: 4
  end

  add_index "invoice_line_items", ["edition_id"], name: "index_invoice_line_items_on_edition_id", using: :btree
  add_index "invoice_line_items", ["invoice_id"], name: "index_invoice_line_items_on_invoice_id", using: :btree
  add_index "invoice_line_items", ["purchase_order_line_item_id"], name: "index_invoice_line_items_on_purchase_order_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "distributor_id",         limit: 4
    t.text     "notes",                  limit: 65535
    t.string   "number",                 limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "received",               limit: 1
    t.datetime "received_when"
    t.integer  "shipping_cost_in_cents", limit: 4
    t.integer  "owner_id",               limit: 4
    t.string   "received_by",            limit: 255
  end

  add_index "invoices", ["distributor_id"], name: "index_invoices_on_distributor_id", using: :btree
  add_index "invoices", ["owner_id"], name: "index_invoices_on_owner_id", using: :btree

  create_table "owners", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "slug",          limit: 255
    t.text     "introduction",  limit: 65535
    t.text     "body",          limit: 65535
    t.integer  "parent_id",     limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "published",     limit: 1
    t.boolean  "is_hero",       limit: 1
    t.string   "layout",        limit: 255
    t.boolean  "is_image_grid", limit: 1
  end

  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["published"], name: "index_pages_on_published", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "publishers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.text     "notes",       limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "purchase_order_line_items", force: :cascade do |t|
    t.integer  "quantity",          limit: 4
    t.integer  "edition_id",        limit: 4
    t.integer  "purchase_order_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "received",          limit: 4
    t.integer  "customer_id",       limit: 4
  end

  add_index "purchase_order_line_items", ["customer_id"], name: "index_purchase_order_line_items_on_customer_id", using: :btree
  add_index "purchase_order_line_items", ["edition_id"], name: "index_purchase_order_line_items_on_edition_id", using: :btree
  add_index "purchase_order_line_items", ["purchase_order_id"], name: "index_purchase_order_line_items_on_purchase_order_id", using: :btree

  create_table "purchase_orders", force: :cascade do |t|
    t.string   "number",         limit: 255
    t.text     "notes",          limit: 65535
    t.integer  "distributor_id", limit: 4
    t.boolean  "ordered",        limit: 1
    t.datetime "ordered_when"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "owner_id",       limit: 4
    t.datetime "order_by_when"
    t.string   "tag",            limit: 255
  end

  add_index "purchase_orders", ["distributor_id"], name: "index_purchase_orders_on_distributor_id", using: :btree
  add_index "purchase_orders", ["owner_id"], name: "index_purchase_orders_on_owner_id", using: :btree

  create_table "return_order_line_items", force: :cascade do |t|
    t.integer  "return_order_id", limit: 4
    t.integer  "copy_id",         limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "return_order_line_items", ["copy_id"], name: "index_return_order_line_items_on_copy_id", using: :btree
  add_index "return_order_line_items", ["return_order_id"], name: "index_return_order_line_items_on_return_order_id", using: :btree

  create_table "return_orders", force: :cascade do |t|
    t.boolean  "posted",         limit: 1
    t.datetime "posted_when"
    t.text     "notes",          limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "distributor_id", limit: 4
  end

  add_index "return_orders", ["distributor_id"], name: "index_return_orders_on_distributor_id", using: :btree
  add_index "return_orders", ["posted"], name: "index_return_orders_on_posted", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sale_order_line_items", force: :cascade do |t|
    t.integer  "sale_order_id",       limit: 4
    t.integer  "copy_id",             limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "sale_price_in_cents", limit: 4
  end

  add_index "sale_order_line_items", ["copy_id"], name: "index_sale_order_line_items_on_copy_id", using: :btree
  add_index "sale_order_line_items", ["sale_order_id"], name: "index_sale_order_line_items_on_sale_order_id", using: :btree

  create_table "sale_orders", force: :cascade do |t|
    t.boolean  "from_pos",            limit: 1
    t.boolean  "from_web",            limit: 1
    t.string   "customer_po",         limit: 255
    t.integer  "customer_id",         limit: 4
    t.integer  "total_in_cents",      limit: 4
    t.boolean  "posted",              limit: 1
    t.integer  "discount_percent",    limit: 4
    t.integer  "tax_amount_in_cents", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id",             limit: 4
    t.text     "notes",               limit: 65535
    t.datetime "posted_when"
  end

  add_index "sale_orders", ["customer_id"], name: "index_sale_orders_on_customer_id", using: :btree
  add_index "sale_orders", ["user_id"], name: "index_sale_orders_on_user_id", using: :btree

  create_table "title_category_memberships", force: :cascade do |t|
    t.integer  "title_id",    limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "title_category_memberships", ["category_id"], name: "index_title_category_memberships_on_category_id", using: :btree
  add_index "title_category_memberships", ["title_id"], name: "index_title_category_memberships_on_title_id", using: :btree

  create_table "title_list_memberships", force: :cascade do |t|
    t.integer  "title_id",      limit: 4
    t.integer  "title_list_id", limit: 4
    t.text     "notes",         limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "title_list_memberships", ["title_id"], name: "index_title_list_memberships_on_title_id", using: :btree
  add_index "title_list_memberships", ["title_list_id"], name: "index_title_list_memberships_on_title_list_id", using: :btree

  create_table "title_lists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.boolean  "public",      limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "description",  limit: 255
    t.text     "introduction", limit: 65535
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
