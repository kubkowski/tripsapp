class Itinerary < ActiveRecord::Base
	validates :location, presence: true
	belongs_to :trip

	class << self

		def monthly_budget
			20000
		end

		def total_estimated_cost(month=Time.now.strftime('%m'))
			self.where("strftime('%m', travel_on) = ?", month).map(&:estimated_cost).reduce(:+) || 0.00
		end
	
		def remaining_budget
			monthly_budget - total_estimated_cost
		end

		def for_year(date=Time.zone.now)
			self.where("travel_on > ? and travel_on < ?", date.beginning_of_year, date.end_of_year)
		end

		def total_yearly_estimated_cost(date=Time.zone.now)
			self.for_year(date).map(&:estimated_cost).reduce(:+) || 0.00
		end
	end

end