class AddTierNumberToTanks < ActiveRecord::Migration
  def change
	add_column :tanks, :tier_number, :integer
  end
end
