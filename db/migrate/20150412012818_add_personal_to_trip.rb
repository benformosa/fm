class AddPersonalToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :personal, :boolean, null:false, default: false
  end
end
