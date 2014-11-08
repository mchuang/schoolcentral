require 'rails_helper'

RSpec.describe AssignmentsController, :type => :controller do

  before(:each) do
    @class0 = FactoryGirl.create(:classroom)
    @admin0   = FactoryGirl.create(:admin_user,   email: "", identifier: "admin0")
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account

    @asgn = FactoryGirl.create(:assignment, classroom: @class0, teacher: @teacher0.account, name: "test_assignment")

    @asgn_params = {
        classroom_id: @class0.id,
        teacher_id: @teacher0.account.id,
        max_points: 30,
        name: "Example Assignment",
        description: "Example Description",
        due: {
            date: "2014-01-01",
            time: "23:59",
        },
    }
  end

  describe "AssignmentsController" do
    it "should redirect to assignment page on create success" do
      sign_in @teacher0
      post :create, @asgn_params
      expect(response).to redirect_to(assignment_path(assigns(:assignment)))
      expect(assigns(:assignment).teacher).to eq(@teacher0.account)
      expect(assigns(:assignment).classroom).to eq(@class0)
    end

    it "should render classroom page on create failure" do
      sign_in @teacher0
      @asgn_params[:name] = nil # causes failure, name is required
      post :create, @asgn_params
      expect(response).to render_template("classrooms/show")
      expect(assigns(:assignment).persisted?).to eq(false)
    end

    it "should show assignment page" do
      sign_in @teacher0
      get :show, id: @asgn
      expect(response.status).to eq(200)
    end

    it "should show student submission" do
      sign_in @student0
      get :show, id: @asgn
      expect(response.status).to eq(200)
      expect(assigns(:submission)).to eq(@student0.account.submission(@asgn.id))
    end
  end
end
