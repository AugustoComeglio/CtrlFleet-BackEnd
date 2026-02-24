class MigrationCtrlfleetOneFive < ActiveRecord::Migration[7.1]
  def change
    add_column :fuel_records, :registered_at, :datetime
    add_column :kilometer_records, :registered_at, :datetime
    add_column :report_types_permissions, :report_type, :string
    add_column :documents, :url, :string
    add_reference :documents, :spare

    create_table :images do |t|
      t.string :url
      t.references :user
      t.references :manager
      t.references :vehicule
      t.references :spare
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :images, :deleted_at
  end
end
