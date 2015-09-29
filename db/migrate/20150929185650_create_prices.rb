class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :course, index: true
      t.string :description
      t.decimal :payment_value, precision: 10, scale: 2
      t.integer :payment_quantity

      t.timestamps
    end
  end
end
