class CreateMedias < ActiveRecord::Migration[6.0]
  def change
    create_table :medias do |t|
      t.references :attachment, null: false, foreign_key: true
      t.references :attachable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
