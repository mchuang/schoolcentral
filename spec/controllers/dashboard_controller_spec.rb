# @author: jdefond, dkang

require 'rails_helper'

RSpec.describe DashboardController, :type => :controller do
	before(:each) do
		@teacher0 = FactoryGirl.create(:teacher_user, email: "" , identifier: "teacher0")
		@admin0   = FactoryGirl.create(:admin_user,   email: "old email", identifier: "admin0")
	end

	describe "DashboardController" do
		it "should require login" do
			[:index, :admin_dashboard, :calendarDates, :calendarEvents].each {|a|
				get a
				expect(response).to redirect_to(new_user_session_path)
			}
		end

		it "index for admin" do
			sign_in @admin0
			get :index, :id => @admin0.id
			expect(response).to render_template('admin_dashboard') 
		end
		it "index for other" do
			sign_in @teacher0
			get :index, :id => @teacher0.id
			expect(response).to render_template('dashboard')
		end
		it "get_admin_dashboard" do
			sign_in @admin0
			get :admin_dashboard, :id => @admin0.id
			expect(response).to render_template('admin_dashboard')
		end
		it "get_admin_dashboard infoTypes" do
			sign_in @admin0
			get :admin_dashboard, :infoType => "Students"
			expect(assigns(:info)).to match_array(Student.all)
			get :admin_dashboard, :infoType => "Teachers"
			expect(assigns(:info)).to match_array(Teacher.all)
			get :admin_dashboard, :infoType => "Classrooms"
			expect(assigns(:info)).to match_array(Classroom.all)
		end

		it "post_admin_dashboard" do
			sign_in @admin0
			post :admin_dashboard, :id => @admin0.id
			expect(response).to render_template('admin_dashboard')
		end
		it "new_form" do 
			sign_in @admin0
			post :new_form
			expect(response).to render_template('admin_dashboard_new')
		end
		it "new_create rendering" do
			sign_in @admin0
			post :new_create
			expect(response).to render_template('admin_dashboard')
		end
		it "new_create Student account" do
			params = {
				infoType: "Students",
				firstname: "First Name",
				middlename: "Middle Name",
				lastname: "Last Name",
				id: "Student_identifier"
			}
			nusers = User.count
			nstudents = Student.count
			sign_in @admin0
			post :new_create, params
			expect(User.count).to eq(nusers + 1)
			expect(Student.count).to eq(nstudents + 1)
		end
		it "new_create Student account" do
			params = {
				infoType: "Teachers",
				firstname: "First Name",
				middlename: "Middle Name",
				lastname: "Last Name",
				id: "Teacher_identifier"
			}
			nusers = User.count
			nteachers = Teacher.count
			sign_in @admin0
			post :new_create, params
			expect(User.count).to eq(nusers + 1)
			expect(Teacher.count).to eq(nteachers + 1)
		end
		it "new_create Classroom" do
			@student0 = FactoryGirl.create(:student_user, :email => "", :identifier => "std0")
			@student1 = FactoryGirl.create(:student_user, :email => "", :identifier => "std1")
			@teacher0 = FactoryGirl.create(:teacher_user, :email => "", :identifier => "tch0")
			params = {
				infoType: "Classrooms",
				name: "Classroom name",
				time: Time.zone.now,
				location: "Room 404 NOT FOUND",
				description: "",
				capacity: 50,
				teacher: @teacher0.identifier,
				students: @student0.identifier + "," + @student1.identifier
			}
			nclassrooms = Classroom.count
			sign_in @admin0
			post :new_create, params
			expect(Classroom.count).to eq(nclassrooms + 1)
		end
	end

	describe "Calendar Dates" do

		before(:each) do
			@now = Time.zone.now
			@class0 = FactoryGirl.create(:classroom)
			@class0.teachers << @teacher0.account
			@event0 = FactoryGirl.create(:event, :name => "test_event0", :classroom => @class0, :startime => @now, :endtime => @now)
			@event1 = FactoryGirl.create(:event, :name => "test_event1", :classroom => @class0, :startime => @now - 2.months, :endtime => @now - 2.months)
		end

		it "should return json calendarDates" do
			sign_in @teacher0
			get :calendarDates, year: 2014, month: 10
			json = JSON.parse(response.body)
			expect(json["year"]).to eq(2014)
			expect(json["month"]).to eq(10)
			expect(json["monthString"]).to eq("October")
			dates = Event.get_dates_for_month(2014, 10).map {|d|
				d.map{|d2|
					d2.strftime("%Y-%m-%d")
				}
			}
			expect(json["dates"]).to match_array(dates)
		end

		it "should return json calendarEvents" do
			sign_in @teacher0
			get :calendarEvents, year: @now.year, month: @now.month
			json = JSON.parse(response.body)
			expect(json["year"]).to eq(@now.year)
			expect(json["month"]).to eq(@now.month)
			expect(json["events"]).to match_array([JSON.parse(@event0.to_json)])
		end

		it "should return json dayEvents" do
			sign_in @teacher0
			get :dayEvents, year: @now.year, month: @now.month, day: @now.day
			json = JSON.parse(response.body)
			date = DateTime.strptime(json["date"].split('T')[0], "%Y-%m-%d")
			expect(date.year).to eq(@now.year)
			expect(date.month).to eq(@now.month)
			expect(date.day).to eq(@now.day)
			expect(json["events"]).to match_array([JSON.parse(@event0.to_json)])
		end
	end
end
