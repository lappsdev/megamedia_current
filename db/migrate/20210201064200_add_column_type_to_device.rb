class AddColumnTypeToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :type, :string
  end
end
