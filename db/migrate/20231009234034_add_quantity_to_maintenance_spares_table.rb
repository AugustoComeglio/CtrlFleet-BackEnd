class AddQuantityToMaintenanceSparesTable < ActiveRecord::Migration[7.1]
  def change
    add_column :maintenance_spares, :quantity, :integer
  end
end
