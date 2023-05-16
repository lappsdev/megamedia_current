class CreatePriceChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :price_checks do |t|
      t.belongs_to :widget, null: false, foreign_key: true
      t.string :barcode
      t.float :price
      t.string :description

      t.timestamps
    end
  end
end
