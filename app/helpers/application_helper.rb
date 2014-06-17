module ApplicationHelper
	def itinerary_row_class(itinerary)
  	'danger' if itinerary.estimated_cost > Itinerary.monthly_budget
	end
end
