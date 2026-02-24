class AddRecordIdsToReports < ActiveRecord::Migration[7.1]
  def up
    add_column :reports, :record_ids, :string unless column_exists? :reports, :record_ids
    add_column :reports, :log, :string
  end

  def down
    remove_column :reports, :record_ids, :string
    remove_column :reports, :log, :string
  end
end
