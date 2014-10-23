require 'spec_helper'
require 'rails_helper'

describe AttendancePolicy do

  before(:each) do
    # Factory_girl definitions found in spec/factories
    # *name*_user factories create a User AND associated account, and
    # return the newly created User instance
    @admin0   = FactoryGirl.create(:admin_user,   email: "", identifier: "admin0")
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @teacher1 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher1")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
    @student1 = FactoryGirl.create(:student_user, email: "", identifier: "student1")
    @class0   = FactoryGirl.create(:classroom,    name: "class0")
    @class1   = FactoryGirl.create(:classroom,    name: "class1")


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
    it{expect(AttendancePolicy::Scope.new(@admin0,Attendance).resolve).to eq(Attendance.all)}
  end

  #Second test
  describe "Teacher Scope on Attendance" do
    it{expect(AttendancePolicy::Scope.new(@teacher0,Attendance).resolve).to eq(Attendance.where({id: @attendance0.id}))}
  end

  #thrid test
  describe "student Scope on Attendance" do 
    it{expect(AttendancePolicy::Scope.new(@student0,Attendance).resolve).to eq(Attendance.where({id: @attendance0.id}))}
  end
  # let(:user) { User.new }

  # subject { AttendancePolicy }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
