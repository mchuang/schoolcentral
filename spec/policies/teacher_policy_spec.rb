# @author: jdefond

require 'spec_helper'
require 'rails_helper'

describe TeacherPolicy do

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
  end


#First test
  describe "Admin Scope on Teacher" do
    it {expect(TeacherPolicy::Scope.new(@admin0,Teacher).resolve).to eq(Teacher.all)}
  end
#Second test
  describe "Teacher Scope on Teacher" do
    it {expect(TeacherPolicy::Scope.new(@teacher0,Teacher).resolve).to eq(Teacher.where({id: @teacher0.account_id}))}
  end
# Third test
  describe "Student Scope on Teacher" do 
    it {expect(TeacherPolicy::Scope.new(@teacher0,Teacher).resolve).to eq(@class0.teachers)}
  end

  permissions :index? do
    it "should allow admin to index teachers" do
      expect(described_class).to permit(@admin0, Teacher)
    end

    it "should allow teacher to index teachers" do
      expect(described_class).to permit(@teacher0, Teacher)
    end

    it "should allow students to index teachers" do
      expect(described_class).to permit(@student0, Teacher)
    end
  end

  permissions :create? do
    it "should allow admins to create teachers" do
      expect(described_class).to permit(@admin0, Teacher)
    end

    it "should not allow teachers to create teachers" do
      expect(described_class).not_to permit(@teacher0, Teacher)
    end

    it "should not allow students to create teacher" do
      expect(described_class).not_to permit(@student0, Teacher)
    end
  end

  permissions :show? do
    it "should allow admins to show teacher" do
      expect(described_class).to permit(@admin0, @teacher0.account)
    end

    it "should allow teachers to show teachers" do
      expect(described_class).to permit(@teacher0, @teacher0.account)
      expect(described_class).to permit(@teacher0, @teacher1.account)
    end

    it "should allow students to show teachers" do
      expect(described_class).to permit(@student0, @teacher0.account)
    end
  end

  permissions :edit? do
    it "should allow admins to edit teachers" do
      expect(described_class).to permit(@admin0, @teacher0.account)
    end

    it "should allow teachers to edit themselves" do
      expect(described_class).to permit(@teacher0, @teacher0.account)
    end

    it "should not allow teachers to edit other teachers" do
      expect(described_class).not_to permit(@teacher0, @teacher1.account)
    end

    it "should not allow students to edit teachers" do
      expect(described_class).not_to permit(@student0, @teacher0.account)
    end
  end

  permissions :update? do
    it "should allow admins to edit teachers" do
      expect(described_class).to permit(@admin0, @teacher0.account)
    end

    it "should allow teachers to edit themselves" do
      expect(described_class).to permit(@teacher0, @teacher0.account)
    end

    it "should not allow teachers to edit other teachers" do
      expect(described_class).not_to permit(@teacher0, @teacher1.account)
    end

    it "should not allow students to edit teachers" do
      expect(described_class).not_to permit(@student0, @teacher0.account)
    end
  end

  permissions :destroy? do
    it "should allow admins to edit teachers" do
      expect(described_class).to permit(@admin0, @teacher0.account)
    end

    it "should not allow teachers to delete themselves" do
      expect(described_class).not_to permit(@teacher0, @teacher0.account)
    end

    it "should not allow teachers to delete other teachers" do
      expect(described_class).not_to permit(@teacher0, @teacher1.account)
    end

    it "should not allow students to delete teachers" do
      expect(described_class).not_to permit(@student0, @teacher0.account)
    end
  end
end
