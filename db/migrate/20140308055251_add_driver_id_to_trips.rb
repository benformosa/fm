class AddDriverIdToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :driver_id, :integer
  end
end
