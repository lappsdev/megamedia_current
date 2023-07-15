class AddScheduleFieldsToAttachment < ActiveRecord::Migration[6.1]
  def change
    add_column :attachments, :schedule_started_at, :datetime
    add_column :attachments, :schedule_finished_at, :datetime
  end
end
