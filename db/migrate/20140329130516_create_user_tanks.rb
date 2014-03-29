class CreateUserTanks < ActiveRecord::Migration
  def change
    create_table :user_tanks do |t|
      t.integer :user_id
      t.integer :tank_id
      t.integer :rating

      t.timestamps
    end
  end
end
