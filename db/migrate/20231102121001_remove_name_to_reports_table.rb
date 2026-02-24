class RemoveNameToReportsTable < ActiveRecord::Migration[7.1]
  def up
    remove_column :reports, :name
  end

  def down
    add_column :reports, :name, :string
  end
end
