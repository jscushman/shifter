class Appointment < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :person
  belongs_to :user
  scope :on, -> (date) { where("starts <= ? AND ends >= ?", date, date) }
  scope :after, -> (date) { where("ends >= ?", date) }
  scope :inyear, -> (year) { where("strftime('%Y', starts) <= ? AND strftime('%Y', ends) >= ?", year, year) }
  
  validate :ends_after_starts

  def ends_after_starts
    if ends.present? && starts.present? && ends < starts
      errors.add(:ends, "before it starts")
    end
  end
  
end
