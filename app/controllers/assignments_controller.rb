class AssignmentsController < ApplicationController
	before_action :require_login

	def new
	end

	def create
		date = nil
		if !params[:due][:date].empty? and !params[:due][:time].empty?
			dateString = params[:due][:date] + " " + params[:due][:time]
			date = DateTime.strptime(dateString, '%Y-%m-%d %H:%M')
		end

		assignmentParams = {
			"teacher_id" => params[:teacher_id],
			"classroom_id" => params[:classroom_id],
			"max_points" => params[:max_points],
			"name" => params[:name],
			"description" => params[:description],
			"due" => date,
		}

		logger.debug "------------------assignmentParams2: #{assignmentParams}"

		@assignment = Assignment.new(assignmentParams)
		#@assignment = Assignment.create(assignment_params) #currently does not work

		if @assignment.save
			redirect_to @assignment
		else
			render "classrooms/show"
		end
	end

	def index
	end

	def show
		@assignment = Assignment.find(params[:id])
		@classroom = Classroom.find(@assignment.classroom_id)
		if current_user.account_type == "Student"
			@submission = current_user.account.submission(@assignment.id)
		end
	end

	def update
	end

	def destroy
	end

	private

	def assignment_params #THIS CURRENTLY DOES NOT WORK
		params.require(:teacher_id)
		params.require(:classroom_id)
		params.require(:name)
		params.require(:due)
	end

	def require_login
	    unless user_signed_in?
	      flash[:error] = "please log in"
	      redirect_to new_user_session_path
	    end
	end

end
