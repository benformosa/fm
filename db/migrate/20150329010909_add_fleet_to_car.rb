class AddFleetToCar < ActiveRecord::Migration
  def change
    add_column :cars, :fleet, :boolean, null:false, default: true
  end
end
