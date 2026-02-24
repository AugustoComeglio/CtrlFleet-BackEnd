class MigrationCtrlfleetTwoOne < ActiveRecord::Migration[7.1]
  def up
    add_column :failures, :priority, :integer

    create_table :maintenance_spares do |t|
      t.references :maintenance
      t.references :spare
      t.timestamps
    end

    add_reference :spares, :brand
    add_column :kilometer_records, :registered_at, :datetime unless column_exists? :kilometer_records, :registered_at
  end

  def down
    remove_column :failures, :priority
    drop_table :maintenance_spares
    remove_column :spares, :brand_id
    remove_column :kilometer_records, :registered_at if column_exists? :kilometer_records, :registered_at
  end
end
