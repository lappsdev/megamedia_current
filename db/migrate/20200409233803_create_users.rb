# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :password_digest
      t.references :group, null: false, foreign_key: true
      t.integer :role, default: 0
      t.timestamps null: false
    end
  end
end
