class ChangeDefaultValueToSpareWarehousesTable < ActiveRecord::Migration[7.1]
  def up
    change_column :spares_warehouses, :quantity, :integer, default: 0
  end

  def down
    change_column :spares_warehouses, :quantity, :integer, default: nil
  end
end
