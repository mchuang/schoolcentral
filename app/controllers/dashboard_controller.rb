# voe

class DashboardController < ApplicationController

	def index
		@classrooms = current_user.account.classrooms

		render 'dashboard'
	end

	def admin_dashboard
		@infoType = params[:infoType]
		case params[:infoType]
			when "Students"
				@info = Students.all
			when "Teachers"
				@info = Teachers.all
			when "Classrooms"
				@info = Clasrooms.all
		end
		render 'admin_dashboard'

	def admin_dashboard_classroom
		@students = Students.all
		@teachers = Teachers.all

end
