class AddReservedDirectionToCabs < ActiveRecord::Migration
  def change
    add_column :cabs, :reserved_direction, :string
  end
end
