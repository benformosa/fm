class AddDateToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :date, :date
  end
end
