module Api
	class MagTypesController < ApplicationController
	
		def index
			@types = MagType.all

			render json: {
				data: @types
			}
		end
	end
end