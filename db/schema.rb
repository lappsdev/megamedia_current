# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_20_103512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "attach_type"
    t.datetime "expired_at"
    t.datetime "schedule_started_at"
    t.datetime "schedule_finished_at"
    t.index ["group_id"], name: "index_attachments_on_group_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "json_attributes"
    t.index ["json_attributes"], name: "index_departments_on_json_attributes", using: :gin
    t.index ["unit_id"], name: "index_departments_on_unit_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.string "mac"
    t.text "notes"
    t.jsonb "data", default: {}
    t.bigint "unit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.bigint "department_id"
    t.index ["data"], name: "index_devices_on_data", using: :gin
    t.index ["department_id"], name: "index_devices_on_department_id"
    t.index ["unit_id"], name: "index_devices_on_unit_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "medias", force: :cascade do |t|
    t.bigint "attachment_id", null: false
    t.string "attachable_type", null: false
    t.bigint "attachable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachable_type", "attachable_id"], name: "index_medias_on_attachable_type_and_attachable_id"
    t.index ["attachment_id"], name: "index_medias_on_attachment_id"
  end

  create_table "price_checks", force: :cascade do |t|
    t.bigint "widget_id", null: false
    t.string "barcode"
    t.float "price"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["widget_id"], name: "index_price_checks_on_widget_id"
  end

  create_table "schedulers", force: :cascade do |t|
    t.string "schedulable_type", null: false
    t.bigint "schedulable_id", null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.jsonb "json_attributes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["schedulable_type", "schedulable_id"], name: "index_schedulers_on_schedulable_type_and_schedulable_id"
  end

  create_table "screens", force: :cascade do |t|
    t.string "name"
    t.bigint "device_id"
    t.bigint "group_id", null: false
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data"], name: "index_screens_on_data", using: :gin
    t.index ["device_id"], name: "index_screens_on_device_id"
    t.index ["group_id"], name: "index_screens_on_group_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "user_type", null: false
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_type", "user_id"], name: "index_sessions_on_user"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.bigint "group_id", null: false
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "data", default: {}
    t.index ["data"], name: "index_units_on_data", using: :gin
    t.index ["group_id"], name: "index_units_on_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "login"
    t.string "password_digest"
    t.bigint "group_id", null: false
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_users_on_group_id"
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "x"
    t.integer "y"
    t.integer "width"
    t.integer "height"
    t.jsonb "data", default: {}
    t.string "type"
    t.bigint "screen_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "department_id"
    t.index ["data"], name: "index_widgets_on_data", using: :gin
    t.index ["department_id"], name: "index_widgets_on_department_id"
    t.index ["screen_id"], name: "index_widgets_on_screen_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attachments", "groups"
  add_foreign_key "departments", "units"
  add_foreign_key "devices", "departments"
  add_foreign_key "devices", "units"
  add_foreign_key "medias", "attachments"
  add_foreign_key "price_checks", "widgets"
  add_foreign_key "screens", "devices"
  add_foreign_key "screens", "groups"
  add_foreign_key "units", "groups"
  add_foreign_key "users", "groups"
  add_foreign_key "widgets", "departments"
  add_foreign_key "widgets", "screens"
end
