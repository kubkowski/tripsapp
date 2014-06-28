class Itinerary < ActiveRecord::Base
	belongs_to :trip
	belongs_to :user


	validates :location, presence: true
	validates :user_id, presence: true
	
	include CalculateEstimatedCost

end