#jeff, daniel
require 'rails_helper'
require 'rack/test'


RSpec.describe SubmissionController, :type => :controller do
	
	before(:each) do
    	@student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
    	@teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    	@class0   = FactoryGirl.create(:classroom,    name: "class0")
    	@assignment0 = FactoryGirl.create(:assignment, teacher_id: @teacher0.account.id, classroom_id: @class0.id, name: 'ass1', due: (Time.now + 3.hours).to_s  )
    	@submission0 = FactoryGirl.create(:submission, :assignment => @assignment0, :student => @student0.account)
    	@file = fixture_file_upload('files/hw.pdf', 'application/pdf')
	end

		describe "Submission Controller" do
	xit "uploads" do 
		params = {file: @file, 
			submission_id: @submission0.id }
		post :upload, params 
		assert_response :redirect
	end
	it "uploads to correct submission" do
		expect(@submission0.file).not_to eq(nil)
	end
end 





  #test from stackoverflow
  # before :each do
  #   @file = fixture_file_upload('files/test_lic.xml', 'text/xml')
  # end
  #
  # it "can upload a license" do
  #   post :uploadLicense, :upload => @file
  #   response.should be_success
  # end

  # to use this you have to implement Capybara
  # it "can upload a license" do
  #   visit upload_license_path
  #   attach_file "uploadLicense", /path/to/file/to/upload
  #   click_button "Upload License"
  # end
  #
  # it "can download an uploaded license" do
  #   visit license_path
  #   click_link "Download Uploaded License"
  #   page.should have_content("Uploaded License")
  # end





#   This is the most useful test

  # require 'test_helper'
  #
  # class UploadsControllerTest < ActionController::TestCase
  #   setup do
  #     @upload = uploads(:one)
  #   end
  #
  #   test "should get index" do
  #     get :index
  #     assert_response :success
  #     assert_not_nil assigns(:uploads)
  #   end
  #
  #   test "should get new" do
  #     get :new
  #     assert_response :success
  #   end
  #
  #   test "should create upload with an image" do
  #     assert_difference('Upload.count') do
  #       uploaded = fixture_file_upload('files/portrait.jpg', 'image/jpeg')
  #       post :create, upload: { name: @upload.name, notes: @upload.notes, owner_id: @upload.owner_id, cargo: uploaded }
  #     end
  #
  #     assert_response :success
  #   end
  #
  #   test "should create upload with a non-image" do
  #     assert_difference('Upload.count') do
  #       uploaded = fixture_file_upload('files/document.rtf', 'application/rtf')
  #       post :create, upload: { name: @upload.name, notes: @upload.notes, owner_id: @upload.owner_id, cargo: uploaded }
  #     end
  #
  #     assert_redirected_to upload_path(assigns(:upload))
  #   end
  #
  #   test "should show upload" do
  #     get :show, id: @upload
  #     assert_response :success
  #   end
  #
  #   test "should get edit" do
  #     get :edit, id: @upload
  #     assert_response :success
  #   end
  #
  #   test "should update upload" do
  #     uploaded = fixture_file_upload('files/portrait.jpg', 'image/jpeg')
  #     patch :update, id: @upload, upload: { name: 'test', notes: 'test', owner_id: @upload.owner_id, cargo: uploaded }
  #     assert_redirected_to upload_path(assigns(:upload))
  #   end
  #
  #   test "should destroy upload" do
  #     assert_difference('Upload.count', -1) do
  #       delete :destroy, id: @upload
  #     end
  #
  #     assert_redirected_to uploads_path
  #   end
  # end




end
