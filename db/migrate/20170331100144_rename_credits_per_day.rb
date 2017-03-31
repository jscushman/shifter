class RenameCreditsPerDay < ActiveRecord::Migration
  def change
    rename_column :calendars, :credits_per_day, :days_per_credit
  end
end
