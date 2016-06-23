class AddActiveToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :active, :boolean
  end
end
