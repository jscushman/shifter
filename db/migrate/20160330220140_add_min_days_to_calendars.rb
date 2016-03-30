class AddMinDaysToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :min_days, :integer
  end
end
