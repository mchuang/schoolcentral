#Jeff
class SubmissionController < ApplicationController
skip_before_action :verify_authenticity_token
	def upload
		logger.debug params
		if params[:file]!=nil
			@assignment = Assignment.find(params[:assignment_id])
			@submission = Submission.find(params[:submission_id])
			@submission.update(file: params[:file])
		end
		render json: {success: "is it even getting here?"}
	end
end
