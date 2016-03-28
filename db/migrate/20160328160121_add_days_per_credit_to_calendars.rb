class AddDaysPerCreditToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :days_per_credit, :integer
  end
end
