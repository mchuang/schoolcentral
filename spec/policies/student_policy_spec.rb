require 'spec_helper'
require 'rails_helper'

describe StudentPolicy do

#First test
    describe "Admin Scope on Student" do
      Admin.delete_all
      Teacher.delete_all
      Student.delete_all
      User.delete_all
      Classroom.delete_all
      
      u = User.create
      u.identifier=55555
      u.account_type='admin'
      a0 = Admin.create(:user=>u)
      s0 = Student.create
      s1 = Student.create        
      
      it {expect(StudentPolicy::Scope.new(a0.user,Student).resolve).to eq(Student.all)}
    end
#Second test
     describe "Teacher Scope on Student" do
      Admin.delete_all
      Teacher.delete_all
      Student.delete_all
      User.delete_all
      Classroom.delete_all
      
      u = User.create
      u.identifier=55555
      u.account_type='teacher'
      t0 = Teacher.create(:user=>u)
      s0 = Student.create
      s1 = Student.create     
      c0 = Classroom.create(:teachers => [Teacher.create], :students => [s1])
      c1 = Classroom.create(:teachers => [t0], :students => [s0])   
      c0.teachers = []
      
     
      it {expect(StudentPolicy::Scope.new(t0.user,Student).resolve).to eq(c1.students)}
    end
# Third test
     describe "Student Scope on Student" do
      Admin.delete_all
      Teacher.delete_all
      Student.delete_all
      User.delete_all
      Classroom.delete_all
     
      u = User.create
      u.identifier=55555
      u.account_type='student'
      t0 = Teacher.create
      s0 = Student.create(:user=>u)
      s1 = Student.create(:user=>User.create)     
      c0 = Classroom.create(:students => [s1])
      c1 = Classroom.create(:teachers => [t0], :students => [s0])   
      c0.teachers = []

      it {expect(StudentPolicy::Scope.new(s0.user,Student).resolve).to eq(Student.where({id: s0.id}))}
    end

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
