class Budget < ActiveRecord::Base

	validates :budget, presence: true
	validates :date_from, presence: true
	validates :date_to, presence: true 

end