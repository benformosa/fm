class AddDistanceToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :distance, :integer
  end
end
