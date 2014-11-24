# @author: jdefond

require 'spec_helper'
require 'rails_helper'

describe StudentPolicy do

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
  end

# First test
  it "Admin scope on Student" do
    expect(StudentPolicy::Scope.new(@admin0, Student).resolve).to match_array(@school1.students)
  end
# Second test
  it "Teacher scope on Student" do
    expect(StudentPolicy::Scope.new(@teacher0, Student).resolve).to match_array(@class0.students)
  end
# Third test
  it "Student scope on Student" do
    expect(StudentPolicy::Scope.new(@student0, Student).resolve).to match_array(Student.where({id: @student0.account_id}))
  end

  permissions :index? do
    it "should allow admin to index students" do
      expect(described_class).to permit(@admin0, Student)
    end

    it "should allow teacher to index scoped students" do
      expect(described_class).to permit(@teacher0, Student)
    end

    it "should not allow students to index students" do
      expect(described_class).not_to permit(@student0, Student)
    end
  end

  permissions :create? do
    it "should allow admins to create students" do
      expect(described_class).to permit(@admin0, Student)
    end

    it "should not allow teachers to create student" do
      expect(described_class).not_to permit(@teacher0, Student)
    end

    it "should not allow students to create student" do
      expect(described_class).not_to permit(@student0, Student)
    end
  end

  permissions :show? do
    it "should allow admins to show students" do
      expect(described_class).to permit(@admin0, @student1.account)
    end

    it "should allow teachers to show scoped students" do
      expect(described_class).to permit(@teacher0, @student0.account)
    end

    it "should not allow teachers to show other students" do
      expect(described_class).not_to permit(@teacher0, @student1.account)
    end

    it "should allow students to show themselves" do
      expect(described_class).to permit(@student0, @student0.account)
    end

    it "should not allow students to show other students" do
      expect(described_class).not_to permit(@student0, @student1.account)
    end
  end

  permissions :edit? do
    it "should allow admins to edit students" do
      expect(described_class).to permit(@admin0, @student0.account)
    end

    it "should not allow teachers to edit students" do
      expect(described_class).not_to permit(@teacher0, @student0.account)
    end

    it "should allow students to edit themselves" do
      expect(described_class).to permit(@student0, @student0.account)
    end

    it "should not allow students to edit other students" do
      expect(described_class).not_to permit(@student0, @student1.account)
    end
  end

  permissions :update? do
    it "should allow admins to edit students" do
      expect(described_class).to permit(@admin0, @student0.account)
    end

    it "should not allow teachers to edit students" do
      expect(described_class).not_to permit(@teacher0, @student0.account)
    end

    it "should allow students to edit themselves" do
      expect(described_class).to permit(@student0, @student0.account)
    end

    it "should not allow students to edit other students" do
      expect(described_class).not_to permit(@student0, @student1.account)
    end
  end

  permissions :destroy? do
    it "should allow admins to edit students" do
      expect(described_class).to permit(@admin0, @student0.account)
    end

    it "should not allow teachers to delete students" do
      expect(described_class).not_to permit(@teacher0, @student0.account)
    end

    it "should not allow students to delete themselves" do
      expect(described_class).not_to permit(@student0, @student0.account)
    end

    it "should not allow students to delete other students" do
      expect(described_class).not_to permit(@student0, @student1.account)
    end
  end
end
