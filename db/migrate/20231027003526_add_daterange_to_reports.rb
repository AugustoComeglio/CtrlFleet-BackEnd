class AddDaterangeToReports < ActiveRecord::Migration[7.1]
  def change
    add_column :reports, :begin_at, :datetime
    add_column :reports, :end_at, :datetime
  end
end
