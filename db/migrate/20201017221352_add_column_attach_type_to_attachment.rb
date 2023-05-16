class AddColumnAttachTypeToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :attach_type, :integer
  end
end
