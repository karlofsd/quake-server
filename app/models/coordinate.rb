class Coordinate < ApplicationRecord
	validates :longitude, comparison:{
		greater_than_or_equal_to: -180.0,
		less_than_or_equal_to: 180.0
	}
	validates :latitude, comparison:{
		greater_than_or_equal_to: -90.0,
		less_than_or_equal_to: 90.0
	}

	belongs_to :feature
end
