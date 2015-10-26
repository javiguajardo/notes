class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :deadline_date
      t.boolean :complete

      t.timestamps null: false
    end
  end
end
