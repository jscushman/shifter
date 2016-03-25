class Appointment < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :person
end
