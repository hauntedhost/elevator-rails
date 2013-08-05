class RenameFromFloor < ActiveRecord::Migration
  def change
    rename_column :cab_calls, :from_floor, :requested_floor
  end
end
