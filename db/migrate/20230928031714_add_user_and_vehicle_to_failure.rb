class AddUserAndVehicleToFailure < ActiveRecord::Migration[7.1]
  def up
    add_reference :failures, :user
    add_reference :failures, :vehicle
  end

  def down
    remove_column :failures, :user_id
    remove_column :failures, :vehicle_id
  end
end
