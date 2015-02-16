class CreateSalesmen < ActiveRecord::Migration
  def change
    create_table :salesmen do |t|
      t.string :name
      t.string :bank
      t.integer :agency
      t.string :account
      t.string :operation

      t.timestamps
    end
  end
end
