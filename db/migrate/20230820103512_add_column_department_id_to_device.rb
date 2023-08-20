class AddColumnDepartmentIdToDevice < ActiveRecord::Migration[6.1]
  def change
    add_reference :devices, :department, null: true, foreign_key: true
  end
end
