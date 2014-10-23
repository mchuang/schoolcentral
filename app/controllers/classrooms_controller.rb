class ClassroomsController < ApplicationController

	def show
		@classrooms = current_user.account.classrooms
		@classroom = Classroom.find(params[:id])
	end
	
end
