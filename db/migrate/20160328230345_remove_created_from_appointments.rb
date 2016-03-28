class RemoveCreatedFromAppointments < ActiveRecord::Migration
  def change
    remove_column :appointments, :created, :datetime
  end
end
