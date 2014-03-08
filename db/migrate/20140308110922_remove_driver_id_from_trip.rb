class RemoveDriverIdFromTrip < ActiveRecord::Migration
  def change
    remove_column :trips, :driver_id, :string
  end
end
