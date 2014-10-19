require 'spec_helper'
require 'rails_helper'

describe AdminPolicy do

  # let(:user) { User.new }

  # subject { AdminPolicy }

  #First test

    Admin.delete_all
    Teacher.delete_all
    Student.delete_all
    User.delete_all
    Classroom.delete_all
    
    #make some admins
    ua = User.create
    ua.account_type='admin'
    a0 = Admin.create(user: ua)
    a1 = Admin.create

    #make some teachers
    ut = User.create
    ut.account_type='teacher'
    t0 = Teacher.create(:user=>ut)

    #make some students
    us = User.create
    us.account_type='student'
    s0 = Student.create(:user=>us)
       

#first test
    describe "Admin Scope on Admin" do
      it {expect(AdminPolicy::Scope.new(a0.user, Admin).resolve ).to eq(Admin.all)} 
    end
#Second test
    describe "Teacher Scope on Admin" do
      it {expect(AdminPolicy::Scope.new(t0.user,Admin).resolve).to eq(Admin.all)}
    end
# Third test
    describe "Student Scope on Admin" do
      it {expect(AdminPolicy::Scope.new(s0.user,Admin).resolve).to eq(Admin.all)}
    end
end

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

