class Booking < ActiveRecord::Base
	belongs_to :user
	belongs_to :properties
	validates_uniqueness_of :user_id, :scope => [:properties_id]
end
