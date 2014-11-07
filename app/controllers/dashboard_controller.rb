# voe

class DashboardController < ApplicationController

	def index
		if current_user.account_type === "Admin"
			render 'admin_dashboard'
		else
			@classrooms = current_user.account.classrooms
			render 'dashboard'
		end
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
					:time => params[:time],
					:location => params[:location],
					:description => params[:description],
					:student_capacity => params[:capacity]
					)
				if User.find_by_identifier(params[:teacher])
					classroom.teachers << User.find_by_identifier(params[:teacher]).account
				end
				params[:students].split(',').each do |student|
					if User.find_by_identifier(student)
						classroom.students << User.find_by_identifier(student).account
					end
				end
				classroom.save
		end
		render 'admin_dashboard'
	end

	def calendarDates
		year = params[:year].to_i
		month = params[:month].to_i
		monthString = Date.new(year, month).strftime("%B")
		dateList = Event.get_dates_for_month(year, month)
		render json: {year: year, month: month, monthString: monthString, dates: dateList}
	end

	def calendarEvents
		year = params[:year].to_i
		month = params[:month].to_i
		render json: {year: year, month: month, test: "SWELLY"}
	end

end
