class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :description
      t.integer :quantity
      t.decimal :unit_value
      t.references :movement, index: true

      t.timestamps
    end
  end
end
