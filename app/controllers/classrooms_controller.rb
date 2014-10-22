class ClassroomsController < ApplicationController

	def show
		@classrooms = Classroom.all
		@classroom = Classroom.find(params[:id])
	end
	
end
