class AddDeletedAtToTables < ActiveRecord::Migration[7.1]
  def up
    add_column :brands, :deleted_at, :datetime
    add_index :brands, :deleted_at
    add_column :debates, :deleted_at, :datetime
    add_index :debates, :deleted_at
    add_column :documents, :deleted_at, :datetime
    add_index :documents, :deleted_at
    add_column :failures, :deleted_at, :datetime
    add_index :failures, :deleted_at
    add_column :fleets, :deleted_at, :datetime
    add_index :fleets, :deleted_at
    add_column :maintenance_types, :deleted_at, :datetime
    add_index :maintenance_types, :deleted_at
    add_column :maintenances, :deleted_at, :datetime
    add_index :maintenances, :deleted_at
    add_column :maintenance_plans, :deleted_at, :datetime
    add_index :maintenance_plans, :deleted_at
    add_column :models, :deleted_at, :datetime
    add_index :models, :deleted_at
    add_column :notification_types, :deleted_at, :datetime
    add_index :notification_types, :deleted_at
    add_column :notifications, :deleted_at, :datetime
    add_index :notifications, :deleted_at
    add_column :permissions, :deleted_at, :datetime
    add_index :permissions, :deleted_at
    add_column :responses, :deleted_at, :datetime
    add_index :responses, :deleted_at
    add_column :spares, :deleted_at, :datetime
    add_index :spares, :deleted_at
    add_column :state_documents, :deleted_at, :datetime
    add_index :state_documents, :deleted_at
    add_column :state_maintenances, :deleted_at, :datetime
    add_index :state_maintenances, :deleted_at
    add_column :unit_types, :deleted_at, :datetime
    add_index :unit_types, :deleted_at
    add_column :units, :deleted_at, :datetime
    add_index :units, :deleted_at
    add_column :user_types, :deleted_at, :datetime
    add_index :user_types, :deleted_at
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
    add_column :vehicle_types, :deleted_at, :datetime
    add_index :vehicle_types, :deleted_at
    add_column :vehicles, :deleted_at, :datetime
    add_index :vehicles, :deleted_at
    add_column :warehouses, :deleted_at, :datetime
    add_index :warehouses, :deleted_at
    add_column :fuel_types, :deleted_at, :datetime unless column_exists? :fuel_types, :deleted_at
    add_index :fuel_types, :deleted_at
    add_column :gas_stations, :deleted_at, :datetime unless column_exists? :gas_stations, :deleted_at
    add_index :gas_stations, :deleted_at

    add_column :fuel_records, :updated_at, :datetime
    add_column :fuel_records, :deleted_at, :datetime
    add_index :fuel_records, :deleted_at

    add_column :notifications, :updated_at, :datetime
    add_column :reports, :report_type, :string

    remove_column :report_types_permissions, :report_type_id if column_exists? :report_types_permissions, :report_type_id

    add_reference :enable_notification_type, :notification_type
  end

  def down
    remove_column :brands, :deleted_at
    remove_column :debates, :deleted_at
    remove_column :documents, :deleted_at
    remove_column :failures, :deleted_at
    remove_column :fleets, :deleted_at
    remove_column :maintenance_types, :deleted_at
    remove_column :maintenances, :deleted_at
    remove_column :maintenance_plans, :deleted_at
    remove_column :models, :deleted_at
    remove_column :notification_types, :deleted_at
    remove_column :notifications, :deleted_at
    remove_column :permissions, :deleted_at
    remove_column :responses, :deleted_at
    remove_column :spares, :deleted_at
    remove_column :state_documents, :deleted_at
    remove_column :state_maintenances, :deleted_at
    remove_column :unit_types, :deleted_at
    remove_column :units, :deleted_at
    remove_column :user_types, :deleted_at
    remove_column :users, :deleted_at
    remove_column :vehicle_types, :deleted_at
    remove_column :vehicles, :deleted_at
    remove_column :warehouses, :deleted_at
    remove_column :fuel_types, :deleted_at
    remove_column :gas_stations, :deleted_at

    remove_column :fuel_records, :updated_at
    remove_column :fuel_records, :deleted_at
    remove_column :notifications, :updated_at
    remove_column :reports, :report_type

    remove_column :enable_notification_type, :notification_type_id
  end
end
