class Group < ActiveRecord::Base
  has_many :people
  has_many :appointments, through: :people
end
