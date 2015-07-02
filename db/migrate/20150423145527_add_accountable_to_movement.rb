class AddAccountableToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :accountable, :boolean
  end
end
