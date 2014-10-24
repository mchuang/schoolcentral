require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

	before(:each) do
		@admin0   = FactoryGirl.create(:admin_user,   email: "old email", identifier: "admin0")
		sign_in @admin0
		@success = "Successfully made changes"
	end

	describe "UsersController" do 
		it "Show assigns @user to current_user" do
			get :show , :id=> @admin0.id
			expect(assigns(:user)).to eq(@admin0)
		end

		it "update_address" do
			@u = {:address=> 'new address'}
			post :update_address , :user =>@u , :id =>@admin0
			expect(response).to redirect_to("/users/show") 
			expect(flash[:success]).to eq(@success)
		end

		it "update_email" do
		 	@u = {:email=> 'new email'}
		 	post :update_email , :user=>@u
		 	expect(response).to redirect_to("/users/show") 
		 	expect(flash[:success]).to eq(@success)
		 end

		it "update correct password" do
			@u ={:password => 'newpassw', :password_confirmation => 'newpassw', :current_password => 'password'}
			post :update_password, :user => @u
			expect(response).to redirect_to("/users/show")
			expect(flash[:success]).to eq(@success)
		end

		it "update_password" do
			@u ={:password => 'new', :password_confirmation => 'new', :current_password => 'notpassword'}
		 	post :update_password , :user => @u
		 	expect(response).to redirect_to("/users/show")
		 	expect(flash[:danger]).to_not eq(@success) 
		end

		it "update_phone" do
			@u = {:phone_mobile=> '123-456'}
		 	post :update_email , :user=>@u
		 	expect(response).to redirect_to("/users/show") 
		 	expect(flash[:success]).to eq(@success)
	    end

	end
end
