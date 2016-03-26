class RemoveDaysFromAppointments < ActiveRecord::Migration
  def change
    remove_column :appointments, :days, :integer
  end
end
