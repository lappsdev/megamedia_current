class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :ip
      t.string :mac

      t.text :notes
      t.jsonb :data, default: {}
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
    add_index :devices, :data, using: :gin

  end
end
