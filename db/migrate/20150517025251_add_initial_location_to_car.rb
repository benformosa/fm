class AddInitialLocationToCar < ActiveRecord::Migration
  def change
    add_column :cars, :initial_location, :string
  end
end
