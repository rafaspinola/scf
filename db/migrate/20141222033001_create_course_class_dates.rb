class CreateCourseClassDates < ActiveRecord::Migration
  def change
    create_table :course_class_dates do |t|
      t.references :course_class, index: true
      t.date :day

      t.timestamps
    end
  end
end
