class ChangeGarageDefault < ActiveRecord::Migration
  def change
    change_column :trips, :garage, :boolean, null:false, default: false
  end
end
