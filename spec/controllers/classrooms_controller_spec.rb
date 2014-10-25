require 'rails_helper'

RSpec.describe ClassroomsController, :type => :controller do



  before(:each) do
    @class0 = FactoryGirl.create(:classroom)
    # @admin0   = FactoryGirl.create(:admin_user,   email: "", identifier: "admin0")
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0",)
    @attendance0 = FactoryGirl.create(:attendance)
    @class0.attendance << @attendance0
    @student0.account.attendance << @attendance0
    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
    @student0.account.classrooms << @class0
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
    it 'set attendance for student' do
      sign_in @teacher0
      
      @c = {:id=> @class0.id}
      @a = {@student0.account.id => 1}

      post :setAttendance, :id => @class0.id, :classroom => @c,:attendance => @a, :date => '2000-01-01'
      expect(assigns(@classroom)['classroom']).to eq(@class0)

    end


  end

end
