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
				@info = Student.all
			when "Teachers"
				@info = Teacher.all
			when "Classrooms"
				@info = Classroom.all
		end
		render 'admin_dashboard'
	end

	def admin_dashboard_classroom
		@students = Student.all
		@teachers = Teacher.all
	end

	def new
		@type = params[:type]
		render 'admin_dashboard_new'
	end

end
