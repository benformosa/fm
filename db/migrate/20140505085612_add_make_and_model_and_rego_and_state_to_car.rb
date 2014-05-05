class AddMakeAndModelAndRegoAndStateToCar < ActiveRecord::Migration
  def change
    add_column :cars, :make, :string
    add_column :cars, :model, :string
    add_column :cars, :rego, :string
    add_column :cars, :state, :string
  end
end
