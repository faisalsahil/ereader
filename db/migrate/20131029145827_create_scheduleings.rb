class CreateScheduleings < ActiveRecord::Migration
  def change
    create_table :scheduleings do |t|
      t.date :schedule_date
      t.integer :author_book_id

      t.timestamps
    end
  end
end
