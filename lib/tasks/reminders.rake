task :reminders => :environment do
  for appointment in Appointment.startson(Date.today + 1) do
    UserMailer.reminder_email(appointment).deliver_now
  end
  for appointment in Appointment.startson(Date.today + 7) do
    UserMailer.reminder_email(appointment).deliver_now
  end
  for appointment in Appointment.startson(Date.today + 30) do
    UserMailer.reminder_email(appointment).deliver_now
  end
end
