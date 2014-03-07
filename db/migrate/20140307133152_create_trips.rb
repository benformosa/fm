class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :odo
      t.integer :last_trip

      t.timestamps
    end
  end
end
