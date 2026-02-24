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

ActiveRecord::Schema[7.2].define(version: 2023_11_06_223205) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_brands_on_deleted_at"
  end

  create_table "debates", force: :cascade do |t|
    t.string "subject", null: false
    t.string "description"
    t.bigint "user_id"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_debates_on_deleted_at"
    t.index ["user_id"], name: "index_debates_on_user_id"
  end

  create_table "document_states", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "state_document_id"
    t.datetime "created_at"
    t.index ["document_id"], name: "index_document_states_on_document_id"
    t.index ["state_document_id"], name: "index_document_states_on_state_document_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.bigint "manager_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.datetime "deleted_at"
    t.datetime "expires_in"
    t.bigint "failure_id"
    t.index ["deleted_at"], name: "index_documents_on_deleted_at"
    t.index ["failure_id"], name: "index_documents_on_failure_id"
    t.index ["manager_id"], name: "index_documents_on_manager_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
    t.index ["vehicle_id"], name: "index_documents_on_vehicle_id"
  end

  create_table "enable_notification_types", force: :cascade do |t|
    t.boolean "enable"
    t.bigint "notification_type_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_type_id"], name: "index_enable_notification_types_on_notification_type_id"
    t.index ["user_id"], name: "index_enable_notification_types_on_user_id"
  end

  create_table "failures", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "maintenance_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "user_id"
    t.bigint "vehicle_id"
    t.integer "priority"
    t.index ["deleted_at"], name: "index_failures_on_deleted_at"
    t.index ["maintenance_plan_id"], name: "index_failures_on_maintenance_plan_id"
    t.index ["user_id"], name: "index_failures_on_user_id"
    t.index ["vehicle_id"], name: "index_failures_on_vehicle_id"
  end

  create_table "fleets", force: :cascade do |t|
    t.string "name"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fleets_on_deleted_at"
    t.index ["manager_id"], name: "index_fleets_on_manager_id"
  end

  create_table "fuel_records", force: :cascade do |t|
    t.integer "quantity"
    t.float "unit_price"
    t.string "observation"
    t.bigint "vehicle_id"
    t.bigint "unit_id"
    t.datetime "created_at"
    t.bigint "gas_station_id"
    t.datetime "registered_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.bigint "fuel_type_id"
    t.index ["deleted_at"], name: "index_fuel_records_on_deleted_at"
    t.index ["fuel_type_id"], name: "index_fuel_records_on_fuel_type_id"
    t.index ["gas_station_id"], name: "index_fuel_records_on_gas_station_id"
    t.index ["unit_id"], name: "index_fuel_records_on_unit_id"
    t.index ["vehicle_id"], name: "index_fuel_records_on_vehicle_id"
  end

  create_table "fuel_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_fuel_types_on_deleted_at"
  end

  create_table "gas_stations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_gas_stations_on_deleted_at"
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.bigint "user_id"
    t.bigint "manager_id"
    t.bigint "vehicle_id"
    t.bigint "spare_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "failure_id"
    t.index ["deleted_at"], name: "index_images_on_deleted_at"
    t.index ["failure_id"], name: "index_images_on_failure_id"
    t.index ["manager_id"], name: "index_images_on_manager_id"
    t.index ["spare_id"], name: "index_images_on_spare_id"
    t.index ["user_id"], name: "index_images_on_user_id"
    t.index ["vehicle_id"], name: "index_images_on_vehicle_id"
  end

  create_table "kilometer_records", force: :cascade do |t|
    t.float "kms_traveled"
    t.string "observation"
    t.bigint "vehicle_id"
    t.bigint "unit_id"
    t.datetime "created_at"
    t.datetime "deleted_at"
    t.datetime "registered_at"
    t.index ["deleted_at"], name: "index_kilometer_records_on_deleted_at"
    t.index ["unit_id"], name: "index_kilometer_records_on_unit_id"
    t.index ["vehicle_id"], name: "index_kilometer_records_on_vehicle_id"
  end

  create_table "maintenance_plans", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_maintenance_plans_on_deleted_at"
    t.index ["user_id"], name: "index_maintenance_plans_on_user_id"
  end

  create_table "maintenance_spares", force: :cascade do |t|
    t.bigint "maintenance_id"
    t.bigint "spare_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["maintenance_id"], name: "index_maintenance_spares_on_maintenance_id"
    t.index ["spare_id"], name: "index_maintenance_spares_on_spare_id"
  end

  create_table "maintenance_states", force: :cascade do |t|
    t.bigint "maintenance_id"
    t.bigint "state_maintenance_id"
    t.datetime "created_at"
    t.index ["maintenance_id"], name: "index_maintenance_states_on_maintenance_id"
    t.index ["state_maintenance_id"], name: "index_maintenance_states_on_state_maintenance_id"
  end

  create_table "maintenance_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_maintenance_types_on_deleted_at"
  end

  create_table "maintenances", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "maintenance_plan_id"
    t.bigint "maintenance_type_id"
    t.bigint "user_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.datetime "estimated_end_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_maintenances_on_deleted_at"
    t.index ["maintenance_plan_id"], name: "index_maintenances_on_maintenance_plan_id"
    t.index ["maintenance_type_id"], name: "index_maintenances_on_maintenance_type_id"
    t.index ["user_id"], name: "index_maintenances_on_user_id"
    t.index ["vehicle_id"], name: "index_maintenances_on_vehicle_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["brand_id"], name: "index_models_on_brand_id"
    t.index ["deleted_at"], name: "index_models_on_deleted_at"
  end

  create_table "notification_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_notification_types_on_deleted_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "message", null: false
    t.bigint "user_id"
    t.datetime "viewed_at"
    t.datetime "created_at"
    t.string "title"
    t.integer "record_id"
    t.string "record_type"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "permissions", force: :cascade do |t|
    t.string "section", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "action"
    t.index ["deleted_at"], name: "index_permissions_on_deleted_at"
  end

  create_table "report_types_permissions", force: :cascade do |t|
    t.bigint "permission_id"
    t.datetime "created_at"
    t.string "report_type"
    t.index ["permission_id"], name: "index_report_types_permissions_on_permission_id"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "report_type"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string "record_ids"
    t.string "log"
  end

  create_table "responses", force: :cascade do |t|
    t.string "details", null: false
    t.bigint "debate_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["debate_id"], name: "index_responses_on_debate_id"
    t.index ["deleted_at"], name: "index_responses_on_deleted_at"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "spares", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_spares_on_brand_id"
    t.index ["deleted_at"], name: "index_spares_on_deleted_at"
  end

  create_table "spares_warehouses", force: :cascade do |t|
    t.bigint "spare_id"
    t.bigint "warehouse_id"
    t.integer "quantity", default: 0
    t.datetime "created_at"
    t.index ["spare_id"], name: "index_spares_warehouses_on_spare_id"
    t.index ["warehouse_id"], name: "index_spares_warehouses_on_warehouse_id"
  end

  create_table "state_documents", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_state_documents_on_deleted_at"
  end

  create_table "state_maintenances", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_state_maintenances_on_deleted_at"
  end

  create_table "state_vehicles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_state_vehicles_on_deleted_at"
  end

  create_table "stock_movements_spares", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "spare_warehouse_id"
    t.datetime "created_at"
    t.index ["spare_warehouse_id"], name: "index_stock_movements_spares_on_spare_warehouse_id"
  end

  create_table "unit_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_unit_types_on_deleted_at"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.bigint "unit_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_units_on_deleted_at"
    t.index ["unit_type_id"], name: "index_units_on_unit_type_id"
  end

  create_table "user_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.boolean "enable_login", default: false
    t.index ["deleted_at"], name: "index_user_types_on_deleted_at"
  end

  create_table "user_types_permissions", force: :cascade do |t|
    t.bigint "user_type_id"
    t.bigint "permission_id"
    t.datetime "created_at"
    t.index ["permission_id"], name: "index_user_types_permissions_on_permission_id"
    t.index ["user_type_id"], name: "index_user_types_permissions_on_user_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "dni", null: false
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.bigint "user_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

  create_table "vehicle_states", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "state_vehicle_id"
    t.datetime "created_at"
    t.index ["state_vehicle_id"], name: "index_vehicle_states_on_state_vehicle_id"
    t.index ["vehicle_id"], name: "index_vehicle_states_on_vehicle_id"
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_vehicle_types_on_deleted_at"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate", null: false
    t.integer "production_year"
    t.string "color"
    t.bigint "vehicle_type_id"
    t.bigint "fuel_type_id"
    t.bigint "warehouse_id"
    t.bigint "manager_id"
    t.bigint "driver_id"
    t.bigint "brand_id"
    t.bigint "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "tank_capacity"
    t.bigint "fleet_id"
    t.datetime "deleted_at"
    t.string "initial_kms"
    t.index ["brand_id"], name: "index_vehicles_on_brand_id"
    t.index ["deleted_at"], name: "index_vehicles_on_deleted_at"
    t.index ["fleet_id"], name: "index_vehicles_on_fleet_id"
    t.index ["fuel_type_id"], name: "index_vehicles_on_fuel_type_id"
    t.index ["license_plate"], name: "index_vehicles_on_license_plate"
    t.index ["manager_id"], name: "index_vehicles_on_manager_id"
    t.index ["model_id"], name: "index_vehicles_on_model_id"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
    t.index ["warehouse_id"], name: "index_vehicles_on_warehouse_id"
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name", null: false
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_warehouses_on_deleted_at"
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
