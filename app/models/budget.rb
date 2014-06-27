class Budget < ActiveRecord::Base

	validates :budget, presence: true
	validates :date_from, presence: true
	validates :date_to, presence: true 

	class << self
		def for_year(date=Time.zone.now)
			self.where("date_from > ? and date_from < ?", date.beginning_of_year, date.end_of_year)
		end

		def yearly_budget(date=Time.zone.now)
    	self.for_year(date).map(&:budget).reduce(:+) || 0.00
  	end

  	def remaining_yearly_budget
    	self.yearly_budget-Itinerary.total_yearly_estimated_cost
  	end

	end

end