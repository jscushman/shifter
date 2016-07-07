class Person < ActiveRecord::Base
  belongs_to :group
  has_many :appointments
  
  default_scope { order('name ASC') }
  
  validates :name, :group_id, :email, :phone, :group_id, presence: true
  validates_plausible_phone :phone
end
