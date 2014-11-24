# @author: jdefond

require 'spec_helper'
require 'rails_helper'

describe AttendancePolicy do

  before(:each) do
    # Factory_girl definitions found in spec/factories
    # *name*_user factories create a User AND associated account, and
    # return the newly created User instance
    @school1  = FactoryGirl.create(:school)
    @admin0   = FactoryGirl.create(:admin_user,   school: @school1, email: "", identifier: "admin0")
    @teacher0 = FactoryGirl.create(:teacher_user, school: @school1, email: "", identifier: "teacher0")
    @teacher1 = FactoryGirl.create(:teacher_user, school: @school1, email: "", identifier: "teacher1")
    @student0 = FactoryGirl.create(:student_user, school: @school1, email: "", identifier: "student0")
    @student1 = FactoryGirl.create(:student_user, school: @school1, email: "", identifier: "student1")
    @class0   = FactoryGirl.create(:classroom,    school: @school1, name: "class0")
    @class1   = FactoryGirl.create(:classroom,    school: @school1, name: "class1")

    @attendance0 = FactoryGirl.create(:attendance)
    @attendance1 = FactoryGirl.create(:attendance)

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
    @class0.attendance << @attendance0
    @class1.teachers << @teacher1.account
    @class1.students << @student1.account
    @class1.attendance << @attendance1

    @student0.account.attendance << @attendance0
    @student1.account.attendance << @attendance1
  end

  #First test
  describe "Admin Scope on Attendance" do
    it{expect(AttendancePolicy::Scope.new(@admin0,Attendance).resolve).to match_array(Attendance.all)}
  end

  #Second test
  describe "Teacher Scope on Attendance" do
    it{
      expect(
        AttendancePolicy::Scope.new(@teacher0,Attendance).resolve
      ).to match_array(Attendance.where({classroom_id: @teacher0.account.classrooms.map(&:id)}))
    }
  end

  #thrid test
  describe "student Scope on Attendance" do 
    it{expect(AttendancePolicy::Scope.new(@student0,Attendance).resolve).to match_array(Attendance.where({id: @attendance0.id}))}
  end

  permissions :index? do
    it "should allow admin to index attendance" do
      expect(described_class).to permit(@admin0, Attendance)
    end

    it "should allow teacher to index scoped attendance" do
      expect(described_class).to permit(@teacher0, Attendance)
    end

    it "should allow students to index scoped attendance" do
      expect(described_class).to permit(@student0, Attendance)
    end
  end

  permissions :create? do
    it "should allow admins to create attendance" do
      expect(described_class).to permit(@admin0, Attendance)
    end

    it "should allow teachers to create attendance" do
      expect(described_class).to permit(@teacher0, Attendance)
    end

    it "should not allow students to create attendance" do
      expect(described_class).not_to permit(@student0, Attendance)
    end
  end

  permissions :edit? do
    it "should allow admins to edit attendance" do
      expect(described_class).to permit(@admin0, @attendance0)
    end

    it "should allow teachers to edit attendance" do
      expect(described_class).to permit(@teacher0, @attendance0)
    end

    it "should not allow teachers to edit attendance for other classes" do
      expect(described_class).not_to permit(@teacher0, @attendance1)
    end

    it "should not allow students to edit attendance" do
      expect(described_class).not_to permit(@student0, @attendance0)
    end
  end

  permissions :update? do
    it "should allow admins to update attendance" do
      expect(described_class).to permit(@admin0, @attendance0)
    end

    it "should allow teachers to update attendance" do
      expect(described_class).to permit(@teacher0, @attendance0)
    end

    it "should not allow teachers to update attendance for other classes" do
      expect(described_class).not_to permit(@teacher0, @attendance1)
    end

    it "should not allow students to update attendance" do
      expect(described_class).not_to permit(@student0, @attendance0)
    end
  end

  permissions :destroy? do
    it "should allow admins to delete attendance" do
      expect(described_class).to permit(@admin0, @attendance0)
    end

    it "should allow teachers to delete attendance" do
      expect(described_class).to permit(@teacher0, @attendance0)
    end

    it "should not allow teachers to delete attendance for other classes" do
      expect(described_class).not_to permit(@teacher0, @attendance1)
    end

    it "should not allow students to delete attendance" do
      expect(described_class).not_to permit(@student0, @attendance0)
    end
  end
end
