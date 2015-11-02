class AddCourseRefToNotebooks < ActiveRecord::Migration
  def change
    add_reference :notebooks, :course, index: true, foreign_key: true
  end
end
