class AddLocationtoTrip < ActiveRecord::Migration
  def change
    add_column :trips, :location, :string
  end
end
