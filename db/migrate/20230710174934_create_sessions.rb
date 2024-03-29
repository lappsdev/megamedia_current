class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.references :user, null: false, polymorphic: true
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end
  end
end
