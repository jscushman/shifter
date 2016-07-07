class Appointment < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :person
  belongs_to :user
  scope :except_id, -> (id) { where("id != ?", id) }
  scope :on, -> (date) { where("starts <= ? AND ends >= ?", date, date) }
  scope :startson, -> (date) { where("starts == ?", date) }
  scope :after, -> (date) { where("ends >= ?", date) }
  scope :started, -> { where("starts <= ?", Time.now.to_formatted_s(:db)) }
  scope :scheduled, -> { where("starts > ?", Time.now.to_formatted_s(:db)) }
  scope :inyears, -> (start_year, end_year) { where("strftime('%Y', starts) <= ? AND strftime('%Y', ends) >= ?", end_year, start_year) }
  scope :incals, -> (cal_list) { where(calendar_id: cal_list.map(&:id)) }
  
  validates :starts, :ends, :calendar_id, :person_id, :user_id, presence: true
  
  validate :ends_after_starts
  def ends_after_starts
    if ends.present? && starts.present? && ends < starts
      errors.add(:ends, "before it starts")
    end
  end
end
