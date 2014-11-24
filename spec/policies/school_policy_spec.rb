# @author: dkang, jdefond

require 'spec_helper'
require 'rails_helper'

describe SchoolPolicy do
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

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
    @class1.teachers << @teacher1.account
    @class1.students << @student0.account
  end

#sanity check
  describe 'Make sure there is only one school' do
    it 'makes sure there is one school' do
      School.all.length.should eql(1)
    end
  end

  describe 'Admin Scope on School' do
    it {expect(SchoolPolicy::Scope.new(@admin0,School).resolve).to match_array([@admin0.school])}

    it 'should only contain the school that the admin belongs to' do
      FactoryGirl.create(:school, name: "other_school1", identifier: "osc1")
      expect(SchoolPolicy::Scope.new(@admin0,School).resolve).not_to(match_array(School.all))
    end
  end

  describe 'Teacher Scope on School' do
    it {expect(SchoolPolicy::Scope.new(@teacher0,School).resolve).to match_array([@teacher0.school])}

    it 'should only contain the school that the teacher belongs to' do
      FactoryGirl.create(:school, name: "other_school1", identifier: "osc1")
      expect(SchoolPolicy::Scope.new(@teacher0,School).resolve).not_to(match_array(School.all))
    end
  end

  describe 'Student Scope on School' do
    it {expect(SchoolPolicy::Scope.new(@student0,School).resolve).to match_array([@student0.school])}

    it 'should contain the school that the student belongs to' do
      FactoryGirl.create(:school, name: "other_school1", identifier: "osc1")
      expect(SchoolPolicy::Scope.new(@student0,School).resolve).not_to(match_array(School.all))
    end
  end
end
