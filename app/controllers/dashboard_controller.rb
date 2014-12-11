# voe

class DashboardController < ApplicationController
	before_action :require_login
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

	def new_form
		@infoType = params[:infoType]
		render 'admin_dashboard_new'
	end

	def new_create
		@infoType = params[:infoType]
		case params[:infoType]
			when "Students"
				resource, pass = User.create_account_random_pass(
					"Student",
					{
					:first_name => params[:firstname],
					:middle_name => params[:middlename],
					:last_name => params[:lastname],
					:identifier => params[:id],
					:school => current_user.school
					})
			when "Teachers"
				resource, pass = User.create_account_random_pass(
					"Teacher",
					{
					:first_name => params[:firstname],
					:middle_name => params[:middlename],
					:last_name => params[:lastname],
					:identifier => params[:id],
					:school => current_user.school
					})
			when "Classrooms"
				resource = classroom = Classroom.create(
					:name => params[:name],
					:time => params[:time],
					:location => params[:location],
					:description => params[:description],
					:student_capacity => params[:capacity],
					:school => current_user.school
					)
				if user = User.find_by_identifier(params[:teacher])
					classroom.teachers << user.account
				end
				params[:students].split(',').map(&:strip).each do |student|
					if user = User.find_by_identifier(student)
						classroom.students << user.account
					end
				end
		end
		if resource && resource.save
			redirect_to dashboard_admin_dashboard_path(infoType: @infoType),
				:notice => "Resource successfully created"
		else
			redirect_to dashboard_new_form_path(infoType: @infoType),
				:notice => "An error occurred, try again"
		end
	end

	def calendarDates
		year = params[:year].to_i
		month = params[:month].to_i
		date = params[:date].to_i
		monthString = Date.new(year, month).strftime("%B")
		dateList = Event.get_dates_for_month(year, month)
		render json: {year: year, month: month, date: date, monthString: monthString, dates: dateList}
	end

	def calendarEvents
		year = params[:year].to_i
		month = params[:month].to_i
		eventList = Event.get_date_range(current_user.account, Event.calendar_first_date(year, month), Event.calendar_last_date(year, month))
		render json: {year: year, month: month, events: eventList}
	end

	def dayEvents
		year = params[:year].to_i
		month = params[:month].to_i
		day = params[:day].to_i
		date = DateTime.new(year, month, day)
		eventList = Event.get_day(current_user.account, date)
		render json: {date: date, events: eventList}
	end

	private

	def require_login
	    unless user_signed_in?
	      flash[:error] = "please log in"
	      redirect_to new_user_session_path
	    end
	end

end
