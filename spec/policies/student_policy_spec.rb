# @author: jdefond

require 'spec_helper'
require 'rails_helper'

describe StudentPolicy do

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
  end

# First test
  it "Admin scope on Student" do
    expect(StudentPolicy::Scope.new(@admin0, Student).resolve).to eq(Student.all)
  end
# Second test
  it "Teacher scope on Student" do
    expect(StudentPolicy::Scope.new(@teacher0, Student).resolve).to eq(@class0.students)
  end
# Third test
  it "Student scope on Student" do
    expect(StudentPolicy::Scope.new(@student0, Student).resolve).to eq(Student.where({id: @student0.account_id}))
  end
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

