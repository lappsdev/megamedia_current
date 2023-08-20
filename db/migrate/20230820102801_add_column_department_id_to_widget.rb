class AddColumnDepartmentIdToWidget < ActiveRecord::Migration[6.1]
  def change
    add_reference :widgets, :department, null: true, foreign_key: true
  end
end
