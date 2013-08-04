class RenameCallToCabCall < ActiveRecord::Migration
  def change
    rename_table :calls, :cab_calls
  end
end
