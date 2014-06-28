class Budget < ActiveRecord::Base

	belongs_to :user	

	validates :budget, presence: true
	validates :date_from, presence: true
	validates :date_to, presence: true
	validate :time_uniqueness, on: :create
	validates :user_id, presence: true

	include CalculateBudget

	class << self

  	def time_uniqueness
  		if Budget.where(['date_from <= ? OR date_to >= ?', date_from, date_to]).size > 0
    		errors[:base] << "Please choose different dates. It seems like you have already set a budget for those dates."
  		end
  	end

	end

end