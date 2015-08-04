class AddTransferMovementToMovements < ActiveRecord::Migration
  def change
    add_reference :movements, :transfer_movement, index: true
  end
end
