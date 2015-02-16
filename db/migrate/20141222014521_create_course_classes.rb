class CreateCourseClasses < ActiveRecord::Migration
  def change
    create_table :course_classes do |t|
      t.references :course, index: true
      t.string :city
      t.string :address
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
