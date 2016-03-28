module OverviewHelper
  def day_of_shift appointment, date
    (date - appointment.starts + 1).to_i
  end
  
  def total_shift_days appointment
    (appointment.ends - appointment.starts + 1).to_i
  end
end
