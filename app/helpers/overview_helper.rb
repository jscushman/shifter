module OverviewHelper
  def day_of_shift appointment, date
    (date - appointment.starts + 1).to_i
  end
  
  def total_shift_days appointment
    (appointment.ends - appointment.starts + 1).to_i
  end
  
  def next_empty_shift calendar
    if calendar.appointments.on(Date.today).size == 0
      return "Today"
    elsif calendar.appointments.on(Date.tomorrow).size == 0
      return "Tomorrow"
    end
    for day in (Date.today + 2)..(Date.today + 365)
      if calendar.appointments.on(day).size == 0
        return day.strftime("%A, %B %-d, %Y") + " (in #{(day - Date.today).to_i} days)"
      end
    end
    return "All covered for the next year"
  end
  
  def output_shifts calendar, date
    shifts = Array.new
    calendar.appointments.on(date).each do |appointment|
      shifts.push(appointment)
    end
  end
end
