class Calendar < ActiveRecord::Base
  has_many :appointments, dependent: :destroy
  has_many :appointments_today, -> { today }, class_name: "Appointment"
  has_many :appointments_tomorrow, -> { tomorrow }, class_name: "Appointment"
  has_many :appointments_upcomingaftertomorrow, -> { upcomingaftertomorrow }, class_name: "Appointment"
  
  default_scope { order('title ASC') }
  
  scope :actives, -> { where(active: true) }
  scope :inactives, -> { where(active: false) }
  
  validates :title, :description, :max_simultaneous, :days_per_credit, :start_time, :end_time, :min_days, :start_end_day, presence: true
  EMAILS_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  
  validate :watchers_valid
  def watchers_valid
    for watcher in watchers.split(/\s*,\s*/)
      if not watcher.match(EMAILS_REGEX)
        errors.add(:watchers, "is not a valid comma-separated list of email addresses")
        return
      end
    end
  end
  
  validates_inclusion_of :max_simultaneous, in: 0..99
  validates_inclusion_of :days_per_credit, in: 1..99
  validates_inclusion_of :min_days, in: 0..99
  validates_inclusion_of :start_end_day, in: -1..6
end
