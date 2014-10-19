require 'spec_helper'
require 'rails_helper'

describe ClassroomPolicy do
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
  describe "Admin Scope on Classroom" do
    it {expect(ClassroomPolicy::Scope.new(a0.user,Classroom).resolve).to eq(Classroom.all)}
  end
#Second test
  describe "Teacher Scope on Classroom" do
    it {expect(ClassroomPolicy::Scope.new(t0.user,Classroom).resolve).to eq(Classroom.where({id: t0.user.account.classrooms.map(&:id)}))}
  end
#Third test
  describe "Student Scope on Classroom" do 
    it {expect(ClassroomPolicy::Scope.new(s0.user,Classroom).resolve).to eq(Classroom.where({id: s0.user.account.classrooms.map(&:id)}))}
  end
end  