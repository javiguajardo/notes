class AddCourseRefToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :course, index: true, foreign_key: true
  end
end
