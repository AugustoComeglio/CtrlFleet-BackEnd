class FixDatetimeToMaintenancePlans < ActiveRecord::Migration[7.1]
  def up
    add_column :maintenance_plans, :created_at, :datetime
    add_column :maintenance_plans, :updated_at, :datetime

    MaintenancePlan.with_deleted.each do |plan|
      next if plan.created_at && plan.updated_at

      plan.update_column :created_at, (Time.zone.now - 5.days)
      plan.update_column :updated_at, (Time.zone.now - 5.days)
    end

    change_column :maintenance_plans, :created_at, :datetime, null: false
    change_column :maintenance_plans, :updated_at, :datetime, null: false

    remove_column :maintenance_plans, :begin_at
    remove_column :maintenance_plans, :end_at
  end

  def down
    remove_column :maintenance_plans, :created_at
    remove_column :maintenance_plans, :updated_at

    add_column :maintenance_plans, :begin_at, :datetime
    add_column :maintenance_plans, :end_at, :datetime
  end
end
