class AddIdentifierToCourseClass < ActiveRecord::Migration
  def change
    add_column :course_classes, :identifier, :string
  end
end
