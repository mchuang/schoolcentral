require 'spec_helper'
require 'rails_helper'

describe SubmissionPolicy do
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
    @assignment0 = FactoryGirl.create(:assignment, teacher_id: @teacher0.account.id, classroom_id: @class0.id, name: 'asg1', due: (Time.now + 3.hours).to_s  )
    @submission0 = FactoryGirl.create(:submission, assignment: @assignment0)

    @class0.teachers << @teacher0.account
    @teacher0.account.assignments << @assignment0
    @class0.assignments << @assignment0
    @class0.students << @student0.account
    @class1.teachers << @teacher1.account
    @class1.students << @student1.account
  end

  #First test
  describe "Admin Scope on Submission" do
    it {expect(SubmissionPolicy::Scope.new(@admin0,Submission).resolve).to match_array(Submission.where(student_id: @school1.students))}
  end
  #Second test
  describe "Teacher Scope on Submission" do
    it {
      expect(SubmissionPolicy::Scope.new(@teacher0,Submission).resolve).to match_array(Submission.where({assignment_id: @teacher0.account.assignments.map(&:id)}))
    }
  end
  #Third test
  describe "Student Scope on Submission" do
    it {
      expect(SubmissionPolicy::Scope.new(@student0,Submission).resolve).to match_array(Submission.where(student_id: @student0.account.id))
    }
  end


  let(:user) { User.new }

  subject { SubmissionPolicy }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
