class ChangeDirectionsToFloats < ActiveRecord::Migration
  def change
    change_column :cabs, :current_direction, :float
    change_column :cabs, :reserved_direction, :float
  end
end
