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
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    if @appointment.calendar.start_end_day >= 0
      if @appointment.starts.wday != @appointment.calendar.start_end_day and not admin?
        flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations start on a ' + Date::DAYNAMES[@appointment.calendar.start_end_day]
        render :new
      elsif @appointment.ends.wday != @appointment.calendar.start_end_day and not admin?
        flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations end on a ' + Date::DAYNAMES[@appointment.calendar.start_end_day]
        render :new
      end
    end
    if @appointment.ends - @appointment.starts + 1 < @appointment.calendar.min_days and not admin?
      flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations be at least ' + @appointment.calendar.min_days.to_s + ' days long.'
      render :new
    elsif @appointment.save
      redirect_to @appointment, flash: { success: 'Appointment was successfully created.' }
    else
      render :new
    end
  end

  # PATCH/PUT /appointments/1
  def update
    begin
      if @appointment.calendar.start_end_day >= 0
        if Date.parse(appointment_params[:starts]).wday != Calendar.find(appointment_params[:calendar_id]).start_end_day and not admin?
          flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations start on a ' + Date::DAYNAMES[@appointment.calendar.start_end_day]
          render :edit
        elsif Date.parse(appointment_params[:ends]).wday != Calendar.find(appointment_params[:calendar_id]).start_end_day and not admin?
          flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations end on a ' + Date::DAYNAMES[@appointment.calendar.start_end_day]
          render :edit
        end
      end
      if Date.parse(appointment_params[:ends]) - Date.parse(appointment_params[:starts]) + 1 < Calendar.find(appointment_params[:calendar_id]).min_days and not admin?
        flash.now[:error] = 'Calendar "' + @appointment.calendar.title + '" requires that reservations be at least ' + @appointment.calendar.min_days.to_s + ' days long.'
        render :edit
      elsif @appointment.update(appointment_params)
        redirect_to @appointment, flash: { success: 'Appointment was successfully updated.' }
      else
        render :edit
      end
    rescue
      flash.now[:error] = "Unkonwn error occured"
      render :edit
    end
  end

  # DELETE /appointments/1
  def destroy
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
      params.require(:appointment).permit(:starts, :ends, :note, :calendar_id, :person_id)
    end    
end
