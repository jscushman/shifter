class Calendar < ActiveRecord::Base
  has_many :appointments
  
  validates :title, :description, :max_simultaneous, :days_per_credit, :min_days, :start_end_day, :no_credit_day, presence: true
  
  validates_inclusion_of :max_simultaneous, in: 0..99
  validates_inclusion_of :days_per_credit, in: 0..99
  validates_inclusion_of :min_days, in: 0..99
  validates_inclusion_of :start_end_day, in: -1..6
end
