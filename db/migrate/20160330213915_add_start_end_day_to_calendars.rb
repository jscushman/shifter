class AddStartEndDayToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :start_end_day, :integer
  end
end
