class Appointment < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :person
  scope :on, -> (date) { where("starts <= ? AND ends >= ?", date, date) }
  scope :inyear, -> (year) { where("strftime('%Y', starts) <= ? AND strftime('%Y', ends) >= ?", year, year) }
end
