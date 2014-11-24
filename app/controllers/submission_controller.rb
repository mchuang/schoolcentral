#Jeff
class SubmissionController < ApplicationController
skip_before_action :verify_authenticity_token
	def upload
		logger.debug params
		if params[:file]!=nil
			@id = params[:submission_id]
			@file = params[:file]
			@submission = Submission.find(@id)
			@submission.update(file: @file)
		end
		redirect_to('assignment/show')
	end
end
