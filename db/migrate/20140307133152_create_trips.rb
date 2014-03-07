class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :odo
      t.integer :last_trip
      t.integer :trip_id

      t.timestamps
    end
    add_index :trips, :trip_id
  end
end
