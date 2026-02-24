class AddEnableLogin < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_types, :enable_login if column_exists? :user_types, :enable_login  
    add_column :user_types, :enable_login, :boolean, default: false 
  end
end
