class AddWatchersToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :watchers, :string
  end
end
