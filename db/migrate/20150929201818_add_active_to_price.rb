class AddActiveToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :enabled, :boolean
  end
end
