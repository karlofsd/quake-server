module Api
	class CommentsController < ApplicationController
		def index
			offset = (Integer(params[:page]) - 1) * Integer(params[:per_page])
			featureId = params[:feature_id]
			@comments = Comment.all
			@comments = Comment.where("feature_id=?", featureId) if featureId != nil
			@comments = @comments.order(date_time: :desc).limit(params[:per_page]).offset(offset)
			totalComments = Comment.count
			data = []
	
			@comments.each do |comment|
				data.push({
					"id": comment["id"],
					"type": "comment",
					"attributes": {
						"body": comment["body"],
						"date_time": comment["date_time"],
						"feature_id": comment["feature_id"]
					},
					})
			end
	
			render json: {
				"data": data,
				"pagination": {
					"page": Integer(params[:page]),
					"total": totalComments,
					"per_page": Integer(params[:per_page])
				}
				}
		end

		def create
			@comment = Comment.new(body: params[:body], date_time: params[:date_time], feature_id: params[:feature_id])
	
			if @comment.save
			render json: @comment, status: :created
			else
			render json: @comment.errors, status: :unprocessable_entity
			end
		end

	end
end