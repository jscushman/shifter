class Calendar < ActiveRecord::Base
  has_many :appointments, dependent: :destroy
  
  scope :actives, -> { where(active: true) }
  scope :inactives, -> { where(active: false) }
  
  validates :title, :description, :max_simultaneous, :credits_per_day, :min_days, :start_end_day, presence: true
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
  validates_inclusion_of :credits_per_day, in: 0..99
  validates_inclusion_of :min_days, in: 0..99
  validates_inclusion_of :start_end_day, in: -1..6
end
