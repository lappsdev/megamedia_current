class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :name
      t.references :group, null: false, foreign_key: true
      t.jsonb :wrpdv_settings, default: {}
      t.jsonb :flex_settings, default: {}
      t.text :notes 
      t.timestamps
    end
    add_index :units, :wrpdv_settings, using: :gin
    add_index :units, :flex_settings, using: :gin
  end
end
