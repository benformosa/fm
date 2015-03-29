class ChangeDefaultValueOfFleet < ActiveRecord::Migration
  def change
    change_column :cars, :fleet, :boolean, :default => false
  end
end
