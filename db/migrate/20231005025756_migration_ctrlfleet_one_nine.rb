class MigrationCtrlfleetOneNine < ActiveRecord::Migration[7.1]
  def up
    remove_column :documents, :failure_id
    add_reference :images, :failure
    rename_table :enable_notification_type, :enable_notification_types
    add_reference :enable_notification_types, :user
  end
  
  def down
    add_reference :documents, :failure
    remove_column :images, :failure_id
    remove_column :enable_notification_types, :user_id
    rename_table :enable_notification_types, :enable_notification_type
  end
end
