class AddUserToAppointments < ActiveRecord::Migration
  def change
    add_reference :appointments, :user, index: true, foreign_key: true
  end
end
