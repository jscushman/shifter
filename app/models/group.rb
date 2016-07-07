class Group < ActiveRecord::Base
  has_many :people
  has_many :appointments, through: :people
  
  default_scope { order('name ASC') }
  
  validates :name, presence: true
end
