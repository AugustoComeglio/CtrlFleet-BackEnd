class MigrationCtrlfleetOneSix < ActiveRecord::Migration[7.1]
  def up
    change_column :vehicles, :initial_kms, :string
    remove_index :vehicles, name: :index_vehicles_on_driver_id
    rename_column :permissions, :name, :section
    add_column :permissions, :action, :string
  end

  def down
    remove_column :vehicles, :initial_kms
    add_column :vehicles, :initial_kms, :float
    add_index :vehicles, :driver_id
    rename_column :permissions, :section, :name
    remove_column :permissions, :action
  end
end
