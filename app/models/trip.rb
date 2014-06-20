class Trip < ActiveRecord::Base
	validates :name, presence: true
	has_many :itineraries

	class << self
		def ordered_by_name
			self.all.order(:name)
		end
	end

	def to_s
		name
	end

end