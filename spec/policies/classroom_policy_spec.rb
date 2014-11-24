# @author: jdefond

require 'spec_helper'
require 'rails_helper'

describe ClassroomPolicy do
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
    @class1.students << @student1.account
  end
  
#First test
  describe "Admin Scope on Classroom" do
    it {expect(ClassroomPolicy::Scope.new(@admin0,Classroom).resolve).to match_array(@school1.classrooms)}
  end
#Second test
  describe "Teacher Scope on Classroom" do
    it {expect(ClassroomPolicy::Scope.new(@teacher0,Classroom).resolve).to match_array(Classroom.where({id: @teacher0.account.classrooms.map(&:id)}))}
  end
#Third test
  describe "Student Scope on Classroom" do 
    it {expect(ClassroomPolicy::Scope.new(@student0,Classroom).resolve).to match_array(Classroom.where({id: @student0.account.classrooms.map(&:id)}))}
  end

  permissions :index? do
    it "should allow admin to index classrooms" do
      expect(described_class).to permit(@admin0, Classroom)
    end

    it "should allow teacher to index scoped classrooms" do
      expect(described_class).to permit(@teacher0, Classroom)
    end

    it "should allow students to index scoped classrooms" do
      expect(described_class).to permit(@student0, Classroom)
    end
  end

  permissions :show? do
    it "should allow admins to show classroom" do
      expect(described_class).to permit(@admin0, @class0)
    end

    it "should allow teachers to show classroom" do
      expect(described_class).to permit(@teacher0, @class0)
    end

    it "should not allow teachers to show other classrooms" do
      expect(described_class).not_to permit(@teacher0, @class1)
    end

    it "should allow students to show classroom" do
      expect(described_class).to permit(@student0, @class0)
    end

    it "should not allow students to show other classrooms" do
      expect(described_class).not_to permit(@student0, @class1)
    end
  end

  permissions :create? do
    it "should allow admins to create classroom" do
      expect(described_class).to permit(@admin0, Classroom)
    end

    it "should not allow teachers to create classroom" do
      expect(described_class).not_to permit(@teacher0, Classroom)
    end

    it "should not allow students to create classroom" do
      expect(described_class).not_to permit(@student0, Classroom)
    end
  end

  permissions :edit? do
    it "should allow admins to edit classroom" do
      expect(described_class).to permit(@admin0, @class0)
    end

    it "should allow teachers to edit classroom" do
      expect(described_class).to permit(@teacher0, @class0)
    end

    it "should not allow teachers to edit other classrooms" do
      expect(described_class).not_to permit(@teacher0, @class1)
    end

    it "should not allow students to edit classroom" do
      expect(described_class).not_to permit(@student0, @class0)
    end
  end

  permissions :update? do
    it "should allow admins to edit classroom" do
      expect(described_class).to permit(@admin0, @class0)
    end

    it "should allow teachers to edit classroom" do
      expect(described_class).to permit(@teacher0, @class0)
    end

    it "should not allow teachers to edit other classrooms" do
      expect(described_class).not_to permit(@teacher0, @class1)
    end

    it "should not allow students to edit classroom" do
      expect(described_class).not_to permit(@student0, @class0)
    end
  end

  permissions :destroy? do
    it "should allow admins to delete class" do
      expect(described_class).to permit(@admin0, @class0)
    end

    it "should not allow teachers to delete class" do
      expect(described_class).not_to permit(@teacher0, @class0)
    end

    it "should not allow students to delete class" do
      expect(described_class).not_to permit(@student0, @class0)
    end
  end
end  
