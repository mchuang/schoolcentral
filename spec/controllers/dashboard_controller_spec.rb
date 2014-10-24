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
end
