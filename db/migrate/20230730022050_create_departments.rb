class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.belongs_to :unit, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
