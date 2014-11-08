require 'spec_helper'
require 'rails_helper'

describe AssignmentPolicy do

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
    @assignment0 = FactoryGirl.create(:assignment, teacher_id: @teacher0.account.id, classroom_id: @class0.id, name: 'ass1', due: (Time.now + 3.hours).to_s  )

    @class0.teachers << @teacher0.account
    @class0.assignments << @assignment0
    @class0.students << @student0.account
    @class1.teachers << @teacher1.account
    @class1.students << @student1.account
  end



  #First test
  describe "Admin Scope on Assignment" do
    it {expect(AssignmentPolicy::Scope.new(@admin0,Assignment).resolve).to eq(Assignment.all)}
  end
  #Second test
  describe "Teacher Scope on Assignment" do
    it {
      expect(AssignmentPolicy::Scope.new(@teacher0,Assignment).resolve).to match_array(Assignment.where({teacher_id: @teacher0.account.id}))
    }
  end
  #Third test
  describe "Student Scope on Assignment" do
    it {
      expect(AssignmentPolicy::Scope.new(@student0,Assignment).resolve).to match_array(Assignment.where({classroom_id: @student0.account.classrooms.map(&:id)}))
    }
  end


  let(:user) { User.new }

  subject { AssignmentPolicy }

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
