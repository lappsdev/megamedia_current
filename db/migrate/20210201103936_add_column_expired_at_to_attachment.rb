class AddColumnExpiredAtToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :expired_at, :datetime
  end
end
