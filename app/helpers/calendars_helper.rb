module CalendarsHelper
  def calendar_appointments(time)
    days_appointments = Array.new
    @calendar.appointments.each do |appointment|
      if (appointment.starts <= time and appointment.starts + appointment.days > time)
        days_appointments = days_appointments << appointment.clone
      end
    end
    return days_appointments
  end
end
