class AddEnableToCar < ActiveRecord::Migration
  def change
    add_column :cars, :enable, :boolean, null:false, default:true
  end
end
