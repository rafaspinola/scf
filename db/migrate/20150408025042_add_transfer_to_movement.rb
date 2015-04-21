class AddTransferToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :transfer, :boolean
    add_reference :movements, :to_account, index: true
  end
end
