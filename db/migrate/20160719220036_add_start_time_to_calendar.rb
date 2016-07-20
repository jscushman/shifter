class AddStartTimeToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :start_time, :time
  end
end
