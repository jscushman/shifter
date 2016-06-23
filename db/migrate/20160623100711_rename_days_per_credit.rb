class RenameDaysPerCredit < ActiveRecord::Migration
  def change
    rename_column :calendars, :days_per_credit, :credits_per_day
  end
end
