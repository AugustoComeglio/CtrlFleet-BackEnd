class MigrationCtrlfleetOneEight < ActiveRecord::Migration[7.1]
  def up
    remove_column :kilometer_records, :registered_at
    remove_column :documents, :spare_id
    add_reference :documents, :failure
    add_column :documents, :expires_in, :datetime
  end

  def down
    add_column :kilometer_records, :registered_at, :datetime
    add_reference :documents, :spare
    remove_column :documents, :failure_id
    remove_column :documents, :expires_in
  end
end
