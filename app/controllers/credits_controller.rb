class CreditsController < ApplicationController
  helper CreditsHelper
  before_action :authenticate_user
  
  def show_cal?(calendar)
    return ((not params[:show_cal].nil?) and params[:show_cal][0] and (params[:show_cal].include? calendar.id.to_s))
  end
  
  def index
    if (not params[:start_year].nil? and params[:start_year].to_i > 0)
      @start_year = params[:start_year]
    else
      @start_year = Date.today.strftime("%Y")
    end
    if (not params[:end_year].nil? and params[:end_year].to_i > 0)
      @end_year = params[:end_year]
    else
      @end_year = Date.today.strftime("%Y")
    end
    if @end_year < @start_year
      @end_year = @start_year
    end
    @calendars = Calendar.all
    @cals_to_show = Array.new
    @calendars.each do |cal|
      if show_cal?(cal)
        @cals_to_show.concat([cal])
      end
    end
    if @cals_to_show.size == 0 or @cals_to_show.size == @calendars.size
      @calendars.each do |cal|
        @cals_to_show.concat([cal])
      end
    end
  end
end
