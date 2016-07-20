class AddEndTimeToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :end_time, :time
  end
end
