class User < ActiveRecord::Base
  has_many :appointments
  has_many :people
  has_many :controlled_appointments, :through => :people, :source => :appointments
  
  before_save { self.email = email.downcase }
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX, :length => { :in => 3..55 }
  has_secure_password

  validates :password, :confirmation => true, on: :create
  validates_length_of :password, :in => 8..50, :on => :create
  validates :password, :confirmation => true, on: :update, allow_blank: true
  validates_length_of :password, :in => 8..50, on: :update, allow_blank: true
  
end
