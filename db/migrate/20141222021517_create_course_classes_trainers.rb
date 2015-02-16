class CreateCourseClassesTrainers < ActiveRecord::Migration
  def change
    create_table :course_classes_trainers do |t|
      t.references :course_class, index: true
      t.references :trainer, index: true

      t.timestamps
    end
  end
end
