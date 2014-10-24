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

	def new_form
		@infoType = params[:infoType]
		render 'admin_dashboard_new'
	end

	def new_create
		@infoType = params[:infoType]
		case params[:infoType]
			when "Students"
				@info = Student.all
				User.create_account_random_pass("Student", {
					:first_name => params[:firstname],
					:middle_name => params[:middlename],
					:last_name => params[:lastname],
					:identifier => params[:id]
					})
			when "Teachers"
				@info = Teacher.all
				User.create_account_random_pass("Teacher", {
					:first_name => params[:firstname],
					:middle_name => params[:middlename],
					:last_name => params[:lastname],
					:identifier => params[:id]
					})
			when "Classrooms"
				@info = Classroom.all
				classroom = Classroom.create(
					:name => params[:name],
					:student_capacity => 30
					)
				classroom.teachers << User.find_by_identifier(params[:teacher]).account
				params[:students].split(',').each do |student|
					classroom.students << User.find_by_identifier(student).account
				end
				classroom.save
		end
		render 'admin_dashboard'
	end

end
