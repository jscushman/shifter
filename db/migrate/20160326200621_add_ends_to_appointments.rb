class AddEndsToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :ends, :date
  end
end
