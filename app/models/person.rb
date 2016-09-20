class Person < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :appointments
  
  default_scope { order('name ASC') }
  
  validates :name, :group, :email, :phone, :user, presence: true
  validates_plausible_phone :phone
end
