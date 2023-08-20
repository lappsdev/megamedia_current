class AddColumnJsonAttributesToDepartment < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :json_attributes, :jsonb
    add_index :departments, :json_attributes, using: :gin
  end
end
