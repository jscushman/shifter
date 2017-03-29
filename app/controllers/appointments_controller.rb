class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action only: [:edit, :update, :destroy] do
    authenticate_specific_user @appointment.user
  end

  # GET /appointments
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    @appointment.credit = true
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    if not admin?
      if @appointment.calendar.start_end_day >= 0
        if @appointment.starts.wday != @appointment.calendar.start_end_day
          flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations start on a ' + Date::DAYNAMES[@appointment.calendar.start_end_day]
          render :new
          return
        elsif @appointment.ends.wday != @appointment.calendar.start_end_day
          flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations end on a ' + Date::DAYNAMES[@appointment.calendar.start_end_day]
          render :new
          return
        end
      end
      days = @appointment.ends - @appointment.starts + 1
      first_test_day = (@appointment.calendar.no_credit_day ? 1 : 0)
      last_test_day = (@appointment.calendar.no_credit_day ? days - 2 : days - 1)
      if first_test_day <= last_test_day
        for day in first_test_day..last_test_day
          if @appointment.calendar.appointments.on(@appointment.starts + day).length >= @appointment.calendar.max_simultaneous
            flash.now[:error] = "Reservation overlaps with at least " + @appointment.calendar.max_simultaneous.to_s + " appointment on " + (@appointment.starts + day).strftime("%B %-d, %Y")
            render :new
            return
          end
        end
      end
      if days < @appointment.calendar.min_days
        flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations be at least ' + @appointment.calendar.min_days.to_s + ' days long.'
        render :new
        return
      end
    end
    if @appointment.save
      UserMailer.new_reservation_email(@appointment).deliver_now
      redirect_to @appointment, flash: { success: 'Appointment was successfully created.' }
    else
      render :new
    end
  end

  # PATCH/PUT /appointments/1
  def update
    begin
      if not admin?
        calendar = Calendar.find(appointment_params[:calendar_id])
        starts = Date.parse(appointment_params[:starts])
        ends = Date.parse(appointment_params[:ends])
        if calendar.start_end_day >= 0
          if starts.wday != calendar.start_end_day
            flash.now[:error] = 'Calendar "' + calendar.title + '" requires that reservations start on a ' + Date::DAYNAMES[calendar.start_end_day]
            render :edit
            return
          elsif ends.wday != calendar.start_end_day
            flash.now[:error] = 'Calendar "' + calendar.title + '" requires that reservations end on a ' + Date::DAYNAMES[calendar.start_end_day]
            render :edit
            return
          end
        end
        days = ends - starts + 1
        first_test_day = (calendar.no_credit_day ? 1 : 0)
        last_test_day = (calendar.no_credit_day ? days - 2 : days - 1)
        if first_test_day <= last_test_day
          for day in first_test_day..last_test_day      
            if calendar.appointments.except_id(@appointment.id).on(starts + day).length >= calendar.max_simultaneous
              flash.now[:error] = "Reservation overlaps with at least " + calendar.max_simultaneous.to_s + " appointment on " + (starts + day).strftime("%B %-d, %Y")
              render :new
              return
            end
          end
        end
        if ends - starts + 1 < calendar.min_days
          flash.now[:error] = 'Calendar "' + calendar.title + '" requires that reservations be at least ' + calendar.min_days.to_s + ' days long.'
          render :edit
          return
        end
      end
      old_appointment = @appointment.dup
      if @appointment.update(appointment_params)
        UserMailer.updated_reservation_email(old_appointment, @appointment).deliver_now
        redirect_to @appointment, flash: { success: 'Appointment was successfully updated.' }
      else
        render :edit
      end
    rescue Exception => ex
      flash.now[:error] = "An error occurred."
      render :edit
    end
  end

  # DELETE /appointments/1
  def destroy
    UserMailer.deleted_reservation_email(@appointment).deliver_now
    @appointment.destroy
    redirect_to appointments_url, flash: { success: 'Appointment was successfully deleted.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:starts, :ends, :note, :calendar_id, :person_id, :credit)
    end    
end
