class AddTransferToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :transfer, :boolean
    add_reference :movements, :to_bank, index: true
  end
end
