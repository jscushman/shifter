module CreditsHelper
  def shift_credit(appointment, start_year, end_year)
    starts = appointment.starts
    if (starts.year < start_year.to_i)
      starts = (start_year + "-01-01").to_datetime
    end
    ends = appointment.ends
    if (ends.year > end_year.to_i)
      ends = (end_year + "-12-31").to_datetime
    end
    days = (ends - starts + 1).to_i
    if appointment.calendar.no_credit_day
      days -= 1
    end
    return days.to_f / (appointment.calendar.days_per_credit)
  end

  def sum_credits(group, start_year, end_year)
    total_credits = 0
    group.appointments.inyear(start_year).each do |shift|
      total_credits += shift_credit shift, start_year, end_year
    end
    return (total_credits*10).round/10.0
  end
end
