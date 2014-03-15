class CreateTanks < ActiveRecord::Migration
  def change
    create_table :tanks do |t|
      t.string :name
      t.text :description
      t.integer :country_id

      t.timestamps
    end
  end
end
