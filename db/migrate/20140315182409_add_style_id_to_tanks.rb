class AddStyleIdToTanks < ActiveRecord::Migration
  def change
	add_column :tanks, :style_id, :integer
  end
end
