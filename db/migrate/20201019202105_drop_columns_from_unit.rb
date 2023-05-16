class DropColumnsFromUnit < ActiveRecord::Migration[6.0]
  def change
    remove_column :units, :wrpdv_settings
    remove_column :units, :flex_settings
  end
end
