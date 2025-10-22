class MigartionCtrlfleetOneFour < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :tank_capacity, :float unless column_exists? :vehicles, :tank_capacity
    add_reference :vehicles, :fleet unless column_exists? :vehicles, :fleet_id

    create_table :enable_notification_type do |t|
      t.boolean :enable
      t.datetime :begin_at
      t.datetime :end_at
    end

    create_table :gas_stations do |t|
      t.string :name
      t.timestamps
      t.datetime :deleted_at
    end

    add_reference :fuel_records, :gas_station

    remove_column :maintenances, :scheduled_hours
    remove_column :maintenances, :real_used_hours
    remove_column :maintenances, :observation

    add_column :maintenances, :priority, :integer
    add_column :maintenances, :begin_at, :datetime
    add_column :maintenances, :end_at, :datetime
    add_column :maintenances, :estimated_end_at, :datetime
  end
end
