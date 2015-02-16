class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.decimal :price6
      t.decimal :price5
      t.decimal :price4
      t.decimal :price3
      t.decimal :price2
      t.decimal :price

      t.timestamps
    end
  end
end
