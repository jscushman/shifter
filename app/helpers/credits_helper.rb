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
  
  def show_cal?(calendar)
    return ((not params[:show_cal].nil?) and params[:show_cal][0] and (params[:show_cal].include? calendar.id.to_s))
  end
  
  def list_cals_to_show
    cals_to_show = Array.new
    Calendar.all.each do |cal|
      if show_cal?(cal)
        cals_to_show.concat([cal.title])
      end
    end
    if cals_to_show.size > 0 and cals_to_show.size < Calendar.all.size
      return cals_to_show.to_sentence
    else
      return "all calendars"
    end
  end
end
