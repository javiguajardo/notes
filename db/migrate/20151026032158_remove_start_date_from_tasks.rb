class RemoveStartDateFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :start_date, :date
  end
end
