# @author: jdefond

require 'spec_helper'
require 'rails_helper'

describe AdminPolicy do

  before(:each) do
    # Factory_girl definitions found in spec/factories
    # *name*_user factories create a User AND associated account, and
    # return the newly created User instance
    @school1  = FactoryGirl.create(:school)
    @admin0   = FactoryGirl.create(:admin_user,   school: @school1, email: "", identifier: "admin0")
    @admin1   = FactoryGirl.create(:admin_user,   school: @school1, email: "", identifier: "admin1")
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

#first test
    describe "Admin Scope on Admin" do
      it {expect(AdminPolicy::Scope.new(@admin0, Admin).resolve).to eq(@school1.admins)} 
    end
#Second test
    describe "Teacher Scope on Admin" do
      it {expect(AdminPolicy::Scope.new(@teacher0,Admin).resolve).to eq(@school1.admins)}
    end
# Third test
    describe "Student Scope on Admin" do
      it {expect(AdminPolicy::Scope.new(@student0,Admin).resolve).to eq(@school1.admins)}
    end

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  permissions :index? do
    it "should allow admin to index admins" do
      expect(described_class).to permit(@admin0)
    end

    it "should allow teacher to index admins" do
      expect(described_class).to permit(@teacher0)
    end

    it "should allow students to index admins" do
      expect(described_class).to permit(@student0)
    end
  end

  permissions :create? do
    it "should allow admins to create admins" do
      expect(described_class).to permit(@admin0, Admin)
    end

    it "should not allow teachers to create admins" do
      expect(described_class).not_to permit(@teacher0, Admin)
    end

    it "should not allow students to create admins" do
      expect(described_class).not_to permit(@student0, Admin)
    end
  end

  permissions :show? do
    it "should allow admins to show admins" do
      expect(described_class).to permit(@admin0, @admin1.account)
    end

    it "should allow teachers to show admins" do
      expect(described_class).to permit(@teacher0, @admin1.account)
    end

    it "should allow students to show admins" do
      expect(described_class).to permit(@student0, @admin1.account)
    end
  end

  permissions :edit? do
    it "should allow admins to edit themselves" do
      expect(described_class).to permit(@admin0, @admin0.account)
    end

    it "should not allow admins to edit other admins" do
      expect(described_class).not_to permit(@admin0, @admin1.account)
    end

    it "should not allow teachers to edit admins" do
      expect(described_class).not_to permit(@teacher0, @admin0.account)
    end

    it "should not allow teachers to edit admins" do
      expect(described_class).not_to permit(@student0, @admin0.account)
    end
  end

  permissions :update? do
    it "should allow admins to update themselves" do
      expect(described_class).to permit(@admin0, @admin0.account)
    end

    it "should not allow admins to update other admins" do
      expect(described_class).not_to permit(@admin0, @admin1.account)
    end

    it "should not allow teachers to update admins" do
      expect(described_class).not_to permit(@teacher0, @admin0.account)
    end

    it "should not allow teachers to update admins" do
      expect(described_class).not_to permit(@student0, @admin0.account)
    end
  end

  permissions :destroy? do
    it "should allow admins to delete themselves" do
      expect(described_class).to permit(@admin0, @admin0.account)
    end

    it "should not allow admins to delete other admins" do
      expect(described_class).not_to permit(@admin0, @admin1.account)
    end

    it "should not allow teachers to delete admins" do
      expect(described_class).not_to permit(@teacher0, @admin0.account)
    end

    it "should not allow teachers to delete admins" do
      expect(described_class).not_to permit(@student0, @admin0.account)
    end
  end
end
