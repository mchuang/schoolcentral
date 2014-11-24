#daniel
class SubmissionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def update
    logger.debug params
    if params[:submission][:file]!=nil
      # @assignment = Assignment.find(params[:submission][:assignment_id])
      @submission = Submission.find(params[:submission][:id])
      @submission.update(file: params[:submission][:file])
      @submission.update(filename: params[:submission][:file].original_filename)
      # render json: {success: params[:submission][:file].original_filename.inspect}
    end
    # render json: {success: params.inspect}
  end
end
