class DashboardController < ApplicationController

	def index
		@classrooms = Classroom.all

		render 'dashboard'
	end

end
