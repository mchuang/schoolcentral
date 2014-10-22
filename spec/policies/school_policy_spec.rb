require 'spec_helper'
require 'rails_helper'

describe SchoolPolicy do
  Admin.delete_all
  Teacher.delete_all
  Student.delete_all
  User.delete_all
  Classroom.delete_all
  School.delete_all

  #create school
  school1 = School.create

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

  school1.users << a0.user
  school1.users << t0.user
  school1.users << s0.user
  school1.users << s1.user

  school1.classrooms << c1


#First test
  describe 'Admin Scope on School' do
    it {expect(SchoolPolicy::Scope.new(a0.user,School).resolve).not_to eq(School.all)}
  end
#Second test
  describe 'Teacher Scope on School' do
    it {expect(SchoolPolicy::Scope.new(t0.user,School).resolve).not_to eq(School.all)}
  end
#Third test
  describe 'Student Scope on School' do
    it {expect(SchoolPolicy::Scope.new(s0.user,School).resolve).not_to eq(School.all)}
  end

#Fourth test
    describe 'Admin Scope on School 2' do
    it {
      expect(SchoolPolicy::Scope.new(a0.user,School).resolve).to(
        match_array(School.where(id: a0.user.school_id))
      )
    }
  end
#Fifth test
  describe 'Teacher Scope on School 2' do
    it {
      expect(SchoolPolicy::Scope.new(t0.user,School).resolve).to(
        match_array(School.where(id: t0.user.school_id))
      )
    }
  end
#Sixth test
  describe 'Student Scope on School 2' do
    it {
      expect(SchoolPolicy::Scope.new(s0.user,School).resolve).to(
        match_array(School.where(id: s0.user.school))
      )
    }
  end
end
