class AddResultCenterToCourseClass < ActiveRecord::Migration
  def change
    add_reference :course_classes, :result_center, index: true
  end
end
