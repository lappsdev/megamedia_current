class CreateScreens < ActiveRecord::Migration[6.0]
  def change
    create_table :screens do |t|
      t.string :name
      t.references :device, null: true, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.jsonb :data
      t.timestamps
    end
    add_index :screens, :data, using: :gin
  end
end
