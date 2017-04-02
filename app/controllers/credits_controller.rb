class CreditsController < ApplicationController
  helper CreditsHelper
  before_action :authenticate_user
  
  def show_cal?(calendar)
    return ((not params[:show_cal].nil?) and params[:show_cal][0] and (params[:show_cal].include? calendar.id.to_s))
  end
  
  def index
    if (not params[:start_date].nil?)
      @start_date = params[:start_date]
    else
      @start_date = Date.today.year.to_s + "-01-01"
    end
    if (not params[:end_date].nil?)
      @end_date = params[:end_date]
    else
      @end_date = Date.today.year.to_s + "-12-31"
    end
    if @end_date < @start_date
      @end_date = @start_date
    end
    @start_date = @start_date.to_datetime
    @end_date = @end_date.to_datetime
    @calendars = Calendar.all
    @cals_to_show = Array.new
    @calendars.each do |cal|
      if show_cal?(cal)
        @cals_to_show.concat([cal])
      end
    end
    if @cals_to_show.size == 0
      @calendars.each do |cal|
        @cals_to_show.concat([cal])
      end
    end
    @all_selected = (@cals_to_show.size == @calendars.size)
  end
end
