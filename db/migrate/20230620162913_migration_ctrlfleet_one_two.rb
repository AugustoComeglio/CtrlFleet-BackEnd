class MigrationCtrlfleetOneTwo < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.references :user
      t.references :notification_type
      t.datetime :viewed_at
      t.datetime :created_at
    end

    create_table :notification_types do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :documents do |t|
      t.string :code, null: false
      t.string :title
      t.references :user
      t.references :manager
      t.references :vehicule
      t.timestamps
    end
    
    create_table :document_states do |t|
      t.references :document
      t.references :state_document
      t.datetime :created_at
    end

    create_table :state_documents do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :fleets do |t|
      t.string :code, null: false
      t.string :name
      t.references :manager
      t.timestamps
    end
    
    create_table :vehicles do |t|
      t.string :license_plate, null: false
      t.float :initial_kms
      t.integer :production_year
      t.string :color
      t.references :vehicle_type
      t.references :fuel_type
      t.references :warehouse
      t.references :manager
      t.references :driver
      t.references :brand
      t.references :model
      t.timestamps
    end

    create_table :vehicle_types do |t|
      t.string :name
      t.timestamps
    end
    
    
    create_table :kilometer_records do |t|
      t.float :kms_traveled
      t.string :observation
      t.references :vehicle
      t.references :unit
      t.datetime :created_at
    end
    
    create_table :fuel_records do |t|
      t.integer :quantity
      t.float :unit_price
      t.string :observation
      t.references :vehicle
      t.references :unit
      t.datetime :created_at
    end
    
    create_table :units do |t|
      t.string :name
      t.references :unit_type
      t.timestamps
    end
    
    create_table :unit_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
