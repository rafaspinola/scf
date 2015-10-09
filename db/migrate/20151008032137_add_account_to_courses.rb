class AddAccountToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :account, index: true
  end
end
