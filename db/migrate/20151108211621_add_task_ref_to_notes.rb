class AddTaskRefToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :task, index: true, foreign_key: true
  end
end
