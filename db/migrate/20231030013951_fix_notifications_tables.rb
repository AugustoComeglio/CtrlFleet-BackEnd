class FixNotificationsTables < ActiveRecord::Migration[7.1]
  def up
    remove_column :enable_notification_types, :begin_at
    remove_column :enable_notification_types, :end_at
    add_column :enable_notification_types, :created_at, :datetime, null: false
    add_column :enable_notification_types, :updated_at, :datetime, null: false
    
    add_column :notifications, :title, :string
    add_column :notifications, :record_id, :integer
    add_column :notifications, :record_type, :string
    remove_column :notifications, :notification_type_id
  end

  def down
    add_column :enable_notification_types, :begin_at, :datetime, null: false
    add_column :enable_notification_types, :end_at, :datetime, null: false
    remove_column :enable_notification_types, :created_at
    remove_column :enable_notification_types, :updated_at

    remove_column :notifications, :title
    remove_column :notifications, :record_id
    remove_column :notifications, :record_type
    add_reference :notifications, :notification_type
  end
end
