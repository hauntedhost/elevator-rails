class ChangeCurrentFloorToFloat < ActiveRecord::Migration
  def change
    change_column :cabs, :current_floor, :float
  end
end
