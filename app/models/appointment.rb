class Appointment < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :person
  belongs_to :user
  scope :except_id, -> (id) { where("id != ?", id) }
  scope :on, -> (date) { where("starts <= ? AND ends >= ?", date, date) }
  scope :after, -> (date) { where("ends >= ?", date) }
  scope :forcredit, -> { where("credit == ?", true) }
  scope :today, -> { where("starts <= ? AND ends >= ?", Date.today, Date.today) }
  scope :tomorrow, -> { where("starts <= ? AND ends >= ?", Date.tomorrow, Date.tomorrow) }
  scope :upcoming, -> { where("starts <= ? AND ends >= ?", Date.today + 365, Date.today) }
  
  validates :starts, :ends, :calendar, :person, :user, presence: true
  
  validate :ends_after_starts
  def ends_after_starts
    if ends < starts
      errors.add(:ends, "before it starts")
    end
  end
end
