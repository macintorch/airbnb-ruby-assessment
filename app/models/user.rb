require 'bcrypt'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
	has_many :properties
	has_many :bookings
	has_many :comments
	attr_accessor :password
	validates :email, presence: true, email: true
	before_create :encrypt_password

	def encrypt_password
		self.encrypted_password = BCrypt::Password.create(self.password)
	end

	def authenticate(password)
		BCrypt::Password.new(self.encrypted_password) == password
	end
end