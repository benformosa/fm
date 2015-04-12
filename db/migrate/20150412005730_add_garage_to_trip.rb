class AddGarageToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :garage, :boolean, null:false, default: true
  end
end
