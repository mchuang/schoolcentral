require 'rails_helper'

RSpec.describe ClassroomsController, :type => :controller do



  before(:each) do
    @class0 = FactoryGirl.create(:classroom)
    # @admin0   = FactoryGirl.create(:admin_user,   email: "", identifier: "admin0")
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")

    # @teacher0.account.classrooms << @class0
    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
  end

  describe "ClassroomsController" do
    it "get_teacher classrooms" do
      sign_in @teacher0
      get :show, :id => @class0.id
      expect(assigns(:classrooms)).to eq(@teacher0.account.classrooms)
    end
    it "get_student classrooms" do
      sign_in @student0
      get :show, :id => @class0.id
      expect(assigns(:classrooms)).to eq(@student0.account.classrooms)
    end
  end

end
