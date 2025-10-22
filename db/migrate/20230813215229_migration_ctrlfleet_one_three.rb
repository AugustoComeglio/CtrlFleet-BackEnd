class MigrationCtrlfleetOneThree < ActiveRecord::Migration[7.0]
  def change
    create_table :fuel_types do |t|
      t.string :name, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    drop_table :report_types
    remove_column :reports, :report_type_id
  end
end
