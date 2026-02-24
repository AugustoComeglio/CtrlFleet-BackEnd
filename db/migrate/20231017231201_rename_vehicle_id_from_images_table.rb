class RenameVehicleIdFromImagesTable < ActiveRecord::Migration[7.1]
  def up
    rename_column :images, :vehicule_id, :vehicle_id
    rename_column :documents, :vehicule_id, :vehicle_id if column_exists? :documents, :vehicule_id
  end

  def down
    rename_column :images, :vehicle_id, :vehicule_id
    rename_column :documents, :vehicle_id, :vehicule_id if column_exists? :documents, :vehicle_id
  end
end
