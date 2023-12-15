class AddColumnUuidToDevice < ActiveRecord::Migration[6.1]
  def change
    add_column :devices, :uuid, :uuid, default: 'gen_random_uuid()', null: false
  end
end
