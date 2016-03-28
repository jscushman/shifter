class Person < ActiveRecord::Base
  belongs_to :group
  has_many :appointments
  
  validates_plausible_phone :phone
end
