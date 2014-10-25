# @author: jdefond

require 'spec_helper'
require 'rails_helper'

describe ClassroomPolicy do
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

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
    @class1.teachers << @teacher1.account
    @class1.students << @student1.account
  end
  
#First test
  describe "Admin Scope on Classroom" do
    it {expect(ClassroomPolicy::Scope.new(@admin0,Classroom).resolve).to eq(Classroom.all)}
  end
#Second test
  describe "Teacher Scope on Classroom" do
    it {expect(ClassroomPolicy::Scope.new(@teacher0,Classroom).resolve).to eq(Classroom.where({id: @teacher0.account.classrooms.map(&:id)}))}
  end
#Third test
  describe "Student Scope on Classroom" do 
    it {expect(ClassroomPolicy::Scope.new(@student0,Classroom).resolve).to eq(Classroom.where({id: @student0.account.classrooms.map(&:id)}))}
  end
end  
