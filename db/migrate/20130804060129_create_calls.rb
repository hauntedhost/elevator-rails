class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.integer :from_floor, :null => false
      t.string :direction, :null => false
      t.integer :cab_id
      t.string :status
      t.timestamps
    end
  end
end
