class AddReferenceFailureToDocuments < ActiveRecord::Migration[7.1]
  def up
    add_reference :documents, :failure
  end

  def down
    remove_column :documents, :failure_id
  end
end
