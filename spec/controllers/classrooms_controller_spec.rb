# @author: jdefond, dkang

require 'rails_helper'

RSpec.describe ClassroomsController, :type => :controller do

  before(:each) do
    @class0 = FactoryGirl.create(:classroom)
    # @admin0   = FactoryGirl.create(:admin_user,   email: "", identifier: "admin0")
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
    @student1 = FactoryGirl.create(:student_user, email: "", identifier: "student1")
    @attendance0 = FactoryGirl.create(:attendance, student: @student0.account)
    @class0.attendance << @attendance0
    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
  end

  describe "ClassroomsController" do
    it "should require login" do
      [:show, :getClassroom].each {|a|
        get a, :id => @class0.id
        expect(response).to redirect_to(new_user_session_path)
      }
    end

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
      expect(response).to redirect_to(classroom_path(@class0))
      expect(assigns(@classroom)['classroom']).to eq(@class0)

      @a = {@student0.account.id => 2}
      post :setAttendance, :id => @class0.id, :classroom => @c, :attendance => @a, :date => '2000-01-02'
      expect(response).to redirect_to(classroom_path(@class0))
      expect(assigns(@classroom)['classroom']).to eq(@class0)
    end

    it "set grades for student" do
      asgn = FactoryGirl.create(:assignment, :classroom => @class0, :teacher => @teacher0.account, :max_points => 50)
      
      sign_in @teacher0
      grades = Hash[@class0.students.map {|s| [s.id.to_s, rand(asgn.max_points).to_s]}]
      params = {
        classroom: {
          id: @class0.id
        },
        assignment: asgn.id,
        grades: grades,
      }
      post :setGrades, params
      expect(response).to redirect_to(classroom_path(@class0))
      grades.each {|id,grade|
        expect(asgn.get_submission(id).grade).to eq(grade.to_i)
      }
    end

    it "get classroom" do
      sign_in @teacher0
      get :getClassroom, id: @class0.id
      expect(response).to render_template("classroominfo")
      expect(assigns(:classroom)).to eq(@class0)
    end

    it "edit classroom" do
      sign_in @teacher0
      params = {
        id: @class0.id,
        course: @class0.name + " updated",
        time: "10:00",
        location: @class0.location + " updated",
        capacity: 20,
        teachers: @teacher0.identifier,
        students: @student0.identifier + "," + @student1.identifier
      }
      post :editClassroom, params
      @class0.reload
      expect(response).to render_template("classroominfo")
      expect(assigns(:classroom)).to eq(@class0)
      expect(@class0.students).to match_array([@student0.account, @student1.account])
      expect(@class0.name).to eq(params[:course])
    end

  end

end
