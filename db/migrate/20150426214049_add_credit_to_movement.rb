class AddCreditToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :credit, :boolean, null: false, default: false
  end
end
