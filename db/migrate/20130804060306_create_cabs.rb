class CreateCabs < ActiveRecord::Migration
  def change
    create_table :cabs do |t|
      t.integer :current_floor, :null => false
      t.string :direction
      t.string :status, :null => false
      t.timestamps
    end
  end
end
