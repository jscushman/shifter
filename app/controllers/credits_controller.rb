class CreditsController < ApplicationController
  helper CreditsHelper
  before_action :authenticate_user
  
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
  end
end
