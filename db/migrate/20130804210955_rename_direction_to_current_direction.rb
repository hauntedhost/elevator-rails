class RenameDirectionToCurrentDirection < ActiveRecord::Migration
  def change
    rename_column :cabs, :direction, :current_direction
  end
end
