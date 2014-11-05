class AssignmentsController < ApplicationController

	def new
	end

	def create
		date = nil
		if !params[:due][:date].empty? and !params[:due][:time].empty?
			dateString = params[:due][:date] + " " + params[:due][:time]
			date = DateTime.strptime(dateString, '%Y-%m-%d %H:%M')
		end

		assignmentParams2 = {
			"teacher_id" => params[:teacher_id],
			"classroom_id" => params[:classroom_id], 
			"max_points" => params[:max_points],
			"name" => params[:name], 
			"description" => params[:description], 
			"due" => date, 
		}

		logger.debug "------------------assignmentParams2: #{assignmentParams2}"

		@assignment = Assignment.create(assignmentParams2)
		#@assignment = Assignment.create(assignment_params) #currently does not work

		if @assignment
			redirect_to @assignment
		else
			render @classroom
		end
	end

	def index
	end

	def show
		@assignment = Assignment.find(params[:id])
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

end
