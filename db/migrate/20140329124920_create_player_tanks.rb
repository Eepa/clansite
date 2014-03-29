class CreatePlayerTanks < ActiveRecord::Migration
  def change
    create_table :player_tanks do |t|
      t.integer :player_id
      t.integer :tank_id
      t.integer :rating

      t.timestamps
    end
  end
end
