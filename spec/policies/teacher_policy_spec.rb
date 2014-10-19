require 'spec_helper'
require 'rails_helper'

describe TeacherPolicy do
  Admin.delete_all
  Teacher.delete_all
  Student.delete_all
  User.delete_all
  Classroom.delete_all

  #create admin
  ua = User.create
  ua.account_type='admin'
  a0 = Admin.create(:user=>ua)

  #create teacher
  ut = User.create
  ut.account_type='teacher'
  t0 = Teacher.create(:user=>ut)
  t1 = Teacher.create(:user=>User.create)    

  #create students
  us = User.create
  us.account_type='student'
  s0 = Student.create(:user=>us)
  s1 = Student.create(:user=>User.create)    

  #create classrooms
  c0 = Classroom.create(:teachers => [t0], :students => [s0])
  c1 = Classroom.create(:teachers=>[t1], :students => [s1])    

  
#First test
  describe "Admin Scope on Teacher" do
    it {expect(TeacherPolicy::Scope.new(a0.user,Teacher).resolve).to eq(Teacher.all)}
  end
#Second test
  describe "Teacher Scope on Teacher" do
    it {expect(TeacherPolicy::Scope.new(t0.user,Teacher).resolve).to eq(Teacher.where({id: t0.id}))}
  end
# Third test
  describe "Student Scope on Teacher" do 
    it {expect(TeacherPolicy::Scope.new(s0.user,Teacher).resolve).to eq(c0.teachers)}
  end
end


  # let(:user) { User.new }

  # subject { TeacherPolicy }

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

