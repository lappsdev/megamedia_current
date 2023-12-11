class AddColumnJsonAttributesToGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :json_attributes, :jsonb
    add_index :groups, :json_attributes, using: :gin
  end
end
