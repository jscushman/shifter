class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :edit, :create, :update, :destroy]

  # GET /calendars
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  def show
    if (not params[:startmonth].nil?)
      begin
        theday = Date.parse(params[:startmonth] + "-01")
      rescue ArgumentError
        theday = Date.today
      end
    else
      theday = Date.today
    end
    @firstday = theday.beginning_of_week(:sunday)
    @startyear = theday.strftime("%Y")
    @startmonth = theday.strftime("%m")
    @months = params[:months].nil? ? 1 : params[:months].to_i
    @months = (@months > 0) ? @months : 1
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      redirect_to @calendar, notice: 'Calendar was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /calendars/1
  def update
    if @calendar.update(calendar_params)
      redirect_to @calendar, notice: 'Calendar was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /calendars/1
  def destroy
    @calendar.destroy
    redirect_to calendars_url, notice: 'Calendar was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:title, :description, :max_simultaneous, :days_per_credit)
    end
end
