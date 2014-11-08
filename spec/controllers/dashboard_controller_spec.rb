# @author: jdefond, dkang

require 'rails_helper'

RSpec.describe DashboardController, :type => :controller do
	before(:each) do
		@teacher0 = FactoryGirl.create(:teacher_user, email: "" , identifier: "teacher0")
		@admin0   = FactoryGirl.create(:admin_user,   email: "old email", identifier: "admin0")
	end

	describe "DashboardController" do
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
		it "new_create" do
			sign_in @admin0
			post :new_create
			expect(response).to render_template('admin_dashboard')
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
