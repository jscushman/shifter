module CreditsHelper
  def shift_credit(appointment, start_date, end_date, scheduled_only)
    appt_starts = appointment.starts
    appt_ends = appointment.ends
    if scheduled_only and appt_starts <= Date.today
      appt_starts = Date.today + 1
    end
    if appt_starts < start_date
      appt_starts = start_date
    end
    if appt_ends > end_date
      appt_ends = end_date
    end
    if not scheduled_only and appt_ends > Date.today
      appt_ends = Date.today
    end
    days = (appt_ends - appt_starts + 1).to_i
    if appointment.calendar.no_credit_day
      days -= 1
    end
    return days.to_f / appointment.calendar.days_per_credit
  end

  def trim num
    i, f = num.to_i, num.round(1)
    i == f ? i : f
  end

  def sum_credits(group, start_date, end_date, cals)
    total_credits = 0
    total_scheduled = 0
    group.credited_appointments.each do |shift|
      if shift.starts <= end_date and shift.ends >= start_date and cals.include?(shift.calendar)
        if shift.starts <= Date.today
          total_credits += shift_credit shift, start_date, end_date, false
        end
        if shift.ends > Date.today
          total_scheduled += shift_credit shift, start_date, end_date, true
        end
      end
    end
    return [trim(total_credits), trim(total_scheduled)]
  end
    
  def list_cals_to_show
    if @cals_to_show.size > 0 and @cals_to_show.size < @calendars.size
      return @cals_to_show.map(&:title).to_sentence
    else
      return "all calendars"
    end
  end
  
  def date_range(start_date, end_date)
    show_first_year = (start_date.year != end_date.year)
    show_second_month = (show_first_year or start_date.month != end_date.month)
    format1 = show_first_year ? "%b %d, %Y," : "%b %d"
    format2 = show_second_month ? "%b %d, %Y," : "%d, %Y,"
    return start_date.strftime(format1) + " to " + end_date.strftime(format2)
    
  end
end
