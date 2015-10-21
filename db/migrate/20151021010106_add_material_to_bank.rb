class AddMaterialToBank < ActiveRecord::Migration
  def change
    add_column :banks, :material, :boolean, null:false, default: 0
  end
end
