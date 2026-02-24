class MigrationCtrlfleetOneSeven < ActiveRecord::Migration[7.1]
  def change
    add_index :vehicles, :license_plate
    add_column :kilometer_records, :deleted_at, :datetime
    add_index :kilometer_records, :deleted_at

    create_table :state_vehicles do |t|
      t.string :name, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :state_vehicles, [:deleted_at], name: 'index_state_vehicles_on_deleted_at'

    create_table :vehicle_states do |t|
      t.references :vehicle
      t.references :state_vehicle
      t.datetime :created_at
    end

    add_reference :fuel_records, :fuel_type
    add_column :user_types, :enable_login, :boolean, default: false if column_exists? :user_types, :enable_login  
  end
end
