class AssignmentsController < ApplicationController

	def new
	end

	def create
		@classroom = Classroom.find(params[:classroom_id])
		if @classroom
			@teacher = @classroom.teachers.first
			dateString = params[:due_date] + " " + params[:due_time]
			date = DateTime.strptime(dateString, '%Y-%m-%d %H:%M')
			assignmentParams = {
				teacher_id: @teacher.id,
				classroom_id: params[:classroom_id], 
				max_points: params[:max_points],
				name: params[:name], 
				description: params[:description], 
				due: date, 
			}
			@assignment = Assignment.create(assignmentParams)
			if @assignment
				redirect_to @assignment
			else
				render @classroom
			end
		else
			render @classroom
		end
	end

	def index
	end

	def show
	end

	def update
	end

	def destroy
	end

end
