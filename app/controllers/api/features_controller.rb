module Api
	class FeaturesController < ApplicationController
	before_action :set_feature, only: %i[ show update destroy ]

	# GET /features
	def index
		offset = (Integer(params[:page]) - 1) * Integer(params[:per_page])
		magType = []
		if params[:mag_type] != nil then
			magType = JSON.parse(params[:mag_type])
		end
		
		@features = Feature.all
		@features = Feature.where(mag_type: magType) if !magType.empty?
		@features = @features.limit(params[:per_page]).offset(offset)
		totalFeatures = Feature.count
		data = []

		@features.each do |feature|
			data.push({
				"id": feature["id"],
				"type": "feature",
				"attributes": {
					"external_id": feature.external_id,
					"magnitude": feature.magnitude,
					"place": feature.place,
					"time": feature.time,
					"tsunami": feature.tsunami,
					"mag_type": feature.mag_type,
					"title": feature.title,
					"coordinates": {
						"longitude": feature.coordinate.longitude,
						"latitude": feature.coordinate.latitude
					}
				},
				"links": {
					"external_url": feature.external_url
				}
				})
		end

		render json: {
			"data": data,
			"pagination": {
				"page": Integer(params[:page]),
				"total": totalFeatures,
				"per_page": Integer(params[:per_page])
			}
			}
	end

	# GET /features/1
	def show
		render json: @feature
	end

	# POST /features
	def create
		@feature = Feature.new(feature_params)

		if @feature.save
		render json: @feature, status: :created, location: @feature
		else
		render json: @feature.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /features/1
	def update
		if @feature.update(feature_params)
		render json: @feature
		else
		render json: @feature.errors, status: :unprocessable_entity
		end
	end

	# DELETE /features/1
	def destroy
		@feature.destroy!
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_feature
		@feature = Feature.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def feature_params
		params.require(:feature).permit(:id, :title)
		end
	end
end
