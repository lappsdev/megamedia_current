class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :name
      t.text :description

      t.references :group, null: false, foreign_key: true
      t.timestamps
    end
  end
end
