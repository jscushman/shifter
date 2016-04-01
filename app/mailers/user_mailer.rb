class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thanks for creating an account!')
  end
  
  def new_reservation_email(appointment)
    @appointment = appointment
    @cced = @appointment.calendar.watchers.split(/\s*,\s*/)
    if @appointment.person.email != @appointment.user.email
      @cced = @cced << @appointment.user.email
    end
    mail(to: @appointment.person.email, cc: @cced, subject: 'Shift scheduled')
  end
  
  def updated_reservation_email(old_appointment, new_appointment)
    @old_appointment = old_appointment
    @new_appointment = new_appointment
    @cced = @new_appointment.calendar.watchers.split(/\s*,\s*/)
    if @new_appointment.person.email != @new_appointment.user.email
      @cced = @cced << @new_appointment.user.email
    end
    if @new_appointment.person.email != @old_appointment.person.email
      @cced = @cced << @old_appointment.person.email
    end
    mail(to: @new_appointment.person.email, cc: @cced, subject: 'Shift updated')
  end
  
  def deleted_reservation_email(appointment)
    @appointment = appointment
    @cced = @appointment.calendar.watchers.split(/\s*,\s*/)
    if @appointment.person.email != @appointment.user.email
      @cced = @cced << @appointment.user.email
    end
    mail(to: @appointment.person.email, cc: @cced, subject: 'Shift removed')
  end
  
  def reminder_email(appointment)
    @appointment = appointment
    mail(to: @appointment.person.email, cc: @appointment.user.email, subject: 'Your upcoming shift')
  end
end
