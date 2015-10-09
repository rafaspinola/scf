class AddFinancialToBank < ActiveRecord::Migration
  def change
    add_column :banks, :financial, :boolean, null:false, default: 0
    add_column :banks, :main, :boolean, null:false, default: 0
  end
end
