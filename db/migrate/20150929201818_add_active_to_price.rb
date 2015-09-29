class AddActiveToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :active, :boolean
  end
end
