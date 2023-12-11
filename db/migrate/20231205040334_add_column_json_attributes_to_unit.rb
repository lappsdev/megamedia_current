class AddColumnJsonAttributesToUnit < ActiveRecord::Migration[6.1]
  def change
    add_column :units, :json_attributes, :jsonb
    add_index :units, :json_attributes, using: :gin
  end
end
