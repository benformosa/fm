class AddCarToTrips < ActiveRecord::Migration
  def change
    add_reference :trips, :car, index: true
  end
end
