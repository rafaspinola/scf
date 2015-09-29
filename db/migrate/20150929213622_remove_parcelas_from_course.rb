class RemoveParcelasFromCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :price6, :string
    remove_column :courses, :price5, :string
    remove_column :courses, :price4, :string
    remove_column :courses, :price3, :string
    remove_column :courses, :price2, :string
    remove_column :courses, :price, :string
  end
end
