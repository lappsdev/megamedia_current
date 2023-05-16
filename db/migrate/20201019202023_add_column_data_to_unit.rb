class AddColumnDataToUnit < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :data, :jsonb, default: {}
    add_index :units, :data, using: :gin
  end
end
