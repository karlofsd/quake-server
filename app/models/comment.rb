class Comment < ApplicationRecord
	validates :body, presence:true
	has_one :feature
end
