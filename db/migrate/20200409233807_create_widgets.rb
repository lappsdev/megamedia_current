class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :name
      t.text :description
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height
      t.jsonb :data
      t.string :type
      t.references :screen, null: false, foreign_key: true

      t.timestamps
    end
    add_index :widgets, :data, using: :gin
  end
end
