class User < ActiveRecord::Base
  has_many :appointments
  
  before_save { self.email = email.downcase }
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX, :length => { :in => 3..55 }
  has_secure_password
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create
end
