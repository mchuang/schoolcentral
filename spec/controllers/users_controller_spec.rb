require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

	before(:each) do
		@admin0   = FactoryGirl.create(:admin_user,   email: "", identifier: "admin0")
		@teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
		@student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
	end

	describe "UsersController" do 
		it "Show assigns @user to current_user" do
			sign_in @admin0
			get :show , id: @admin0.id
			expect(assigns(:user)).to eq(@admin0)
		end

		it "update_address" do
			sign_in @admin0
			post :update_address, email: "succ@ces", id: @admin0.id
			expect(response).to redirect_to(:show) 
		end
	end
end
