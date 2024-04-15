class Feature < ApplicationRecord
	validates :external_id, uniqueness: true
	validates :title, presence: true
	validates :place, presence: true
	validates :external_url, presence: true
	validates :mag_type, presence: true
	validates :magnitude, comparison:{
		greater_than_or_equal_to: -1.0,
		less_than_or_equal_to: 10.0
	}

	has_one :coordinate
	has_many :comment
end
