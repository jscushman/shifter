class AddNoCreditDayToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :no_credit_day, :boolean
  end
end
