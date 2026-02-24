class RemoveCodeColumnFromAllTables < ActiveRecord::Migration[7.1]
  def up
    remove_column :debates, :code
    remove_column :fleets, :code
    remove_column :maintenance_plans, :code
    remove_column :maintenances, :code
    remove_column :spares, :code
    remove_column :warehouses, :code
    remove_column :documents, :code
  end

  def down
    add_column :debates, :code, :string
    add_column :fleets, :code, :string
    add_column :maintenance_plans, :code, :string
    add_column :maintenances, :code, :string
    add_column :spares, :code, :string
    add_column :warehouses, :code, :string
    add_column :documents, :code, :string
  end
end
