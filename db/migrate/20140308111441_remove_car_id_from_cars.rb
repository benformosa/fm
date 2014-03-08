class RemoveCarIdFromCars < ActiveRecord::Migration
  def change
    remove_column :cars, :car_id, :string
  end
end
