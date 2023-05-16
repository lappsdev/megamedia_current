class ChangeDefaultValueForDataFromWidget < ActiveRecord::Migration[6.0]
  def change
    change_column_default :widgets, :data, {}
  end
end
