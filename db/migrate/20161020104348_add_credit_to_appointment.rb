class AddCreditToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :credit, :boolean
  end
end
