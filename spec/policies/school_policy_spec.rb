# @author: dkang, jdefond

require 'spec_helper'
require 'rails_helper'

describe SchoolPolicy do


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
    @class1.students << @student0.account

    @school1 = School.create
    @school1.users << @admin0
    @school1.users << @teacher0
    @school1.users << @student0
    @school1.users << @student1
    @school1.classrooms << @class1
  end

#sanity check
  describe 'Make sure there is only one school' do
    it 'makes sure there is one school' do
      School.all.length.should eql(1)
    end
  end
#First test
  describe 'Admin Scope on School' do

    it {expect(SchoolPolicy::Scope.new(@admin0,School).resolve).not_to eq(School.all)}
  end
#Second test
  describe 'Teacher Scope on School' do
    it {expect(SchoolPolicy::Scope.new(@teacher0,School).resolve).not_to eq(School.all)}
  end
#Third test
  describe 'Student Scope on School' do
    it {expect(SchoolPolicy::Scope.new(@student0,School).resolve).not_to eq(School.all)}
  end
#Fourth test
  describe 'Admin Scope on School 2' do
    it {
      expect(SchoolPolicy::Scope.new(@admin0,School).resolve).to(
        match_array(School.where(id: @admin0.school_id))
      )
    }
  end
#Fifth test
  describe 'Teacher Scope on School 2' do
    it {
      expect(SchoolPolicy::Scope.new(@teacher0,School).resolve).to(
        match_array(School.where(id: @teacher0.school_id))
      )
    }
  end
#Sixth test
  describe 'Student Scope on School 2' do
    it {
      expect(SchoolPolicy::Scope.new(@student0,School).resolve).to(
        match_array(School.where(id: @student0.school))
      )
    }
  end
#Seventh test
  describe 'Admin Scope on School 3' do
    it 'should contain the school that the admin belongs to' do
      expect(SchoolPolicy::Scope.new(@admin0,School).resolve).to(match_array(School.where(id: @admin0.school_id)))
    end
    it 'should only contain the school that the admin belongs to' do
      FactoryGirl.create(:school, name: "other_school1")
      expect(SchoolPolicy::Scope.new(@admin0,School).resolve).not_to(match_array(School.all))
    end
  end
#Eigth test
  describe 'Teacher Scope on School 3' do
    it 'should contain the school that the teacher belongs to' do
      expect(SchoolPolicy::Scope.new(@teacher0,School).resolve).to(match_array(School.where(id: @teacher0.school_id)))
    end
    it 'should only contain the school that the teacher belongs to' do
      FactoryGirl.create(:school, name: "other_school1")
      expect(SchoolPolicy::Scope.new(@teacher0,School).resolve).not_to(match_array(School.all))
    end
  end
#Ninth test
  describe 'Student Scope on School 3' do
    it 'should contain the school that the student belongs to' do
      expect(SchoolPolicy::Scope.new(@student0,School).resolve).to( match_array(School.where(id: @student0.school)) )
    end
    it 'should contain the school that the student belongs to' do
      FactoryGirl.create(:school, name: "other_school1")
      expect(SchoolPolicy::Scope.new(@student0,School).resolve).not_to(match_array(School.all))
    end
  end
end
