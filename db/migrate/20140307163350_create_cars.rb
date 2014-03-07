class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :car_id
      t.integer :start_odo
      t.string :name

      t.timestamps
    end
    add_index :cars, :car_id
  end
end
