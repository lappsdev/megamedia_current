class AddColumnWeekdaysToAttachment < ActiveRecord::Migration[6.1]
  def change
    add_column :attachments, :weekdays, :boolean, array: true, default: [1, 1, 1, 1, 1, 1, 1]
    add_index :attachments, :weekdays, using: 'gin'
  end
end
