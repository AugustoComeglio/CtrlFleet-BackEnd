class MigrationCtrlfleetOneOne < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :models do |t|
      t.string :name, null: false
      t.references :brand
      t.timestamps
    end

    create_table :spares do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.timestamps
    end

    # TODO: ver si la traduccion correcta de deposito es warehouse o deposit
    create_table :warehouses do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :location
      t.timestamps
    end

    # Parametrizacion entre Deposito y Repuesto
    create_table :spares_warehouses do |t|
      t.references :spare
      t.references :warehouse
      t.integer :quantity
      t.datetime :created_at
    end

    # Parametrizacion MovimientoStockRepuesto
    create_table :stock_movements_spares do |t|
      t.integer :quantity, null: false
      t.references :spare_warehouse
      t.datetime :created_at
    end

    create_table :reports do |t|
      t.string :name, null: false
      t.references :report_type
      t.timestamps
    end

    create_table :report_types do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :users do |t|
      t.integer :dni, null: false
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :password, null: false
      t.string :password_confirmation, null: false
      t.references :user_type
      t.timestamps
    end

    create_table :user_types do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :permissions do |t|
      t.string :name, null: false
      t.timestamps
    end

    # Parametrizacion TipoReporte y Permiso de Usuario
    create_table :report_types_permissions do |t|
      t.references :report_type
      t.references :permission
      t.datetime :created_at
    end

    # Parametrizacion TipoUsuario y Permiso de Usuario
    create_table :user_types_permissions do |t|
      t.references :user_type
      t.references :permission
      t.datetime :created_at
    end

    create_table :maintenance_plans do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.references :user
      t.datetime :begin_at
      t.datetime :end_at
    end

    create_table :maintenances do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :description
      t.string :observation
      t.float :scheduled_hours
      t.float :real_used_hours
      t.references :maintenance_plan
      t.references :maintenance_type
      t.references :user
      t.references :vehicle
      t.timestamps
    end

    create_table :maintenance_types do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :state_maintenances do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :maintenance_states do |t|
      t.references :maintenance
      t.references :state_maintenance
      t.datetime :created_at
    end

    create_table :failures do |t|
      t.string :name, null: false
      t.string :description
      t.references :maintenance_plan
      t.timestamps
    end

    create_table :debates do |t|
      t.string :code, null: false
      t.string :subject, null: false
      t.string :description
      t.references :user
      t.datetime :begin_at
      t.datetime :end_at
    end

    create_table :responses do |t|
      t.string :details, null: false
      t.references :debate
      t.references :user
      t.timestamps
    end
  end
end
