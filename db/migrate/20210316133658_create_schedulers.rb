class CreateSchedulers < ActiveRecord::Migration[6.0]
  def change
    create_table :schedulers do |t|
      t.references :schedulable, polymorphic: true, null: false
      t.datetime :started_at
      t.datetime :finished_at
      t.jsonb :json_attributes

      t.timestamps
    end
  end
end
