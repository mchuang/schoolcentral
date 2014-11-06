require 'rails_helper'

RSpec.describe Assignment, :type => :model do

  before(:each) do
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @teacher1 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher1")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
    @student1 = FactoryGirl.create(:student_user, email: "", identifier: "student1")
    @student2 = FactoryGirl.create(:student_user, email: "", identifier: "student2")
    @class0   = FactoryGirl.create(:classroom,    name: "class0")

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
  end
  
  it "should error on nil classroom" do
    expect {
        FactoryGirl.create(:assignment, :classroom => nil)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should seed submissions when assignment is created" do
    existing = Submission.count
    asgn = FactoryGirl.create(:assignment, :classroom_id => @class0.id)
    expect(
      Submission.count - existing
    ).to eq(asgn.classroom.students.count)
  end

  it "should create an event when assignment is created" do
    asgn = FactoryGirl.create(:assignment, :classroom_id => @class0.id)
    expect(asgn.event).not_to         eq(nil)
    expect(asgn.event.name).to        eq(asgn.name)
    expect(asgn.event.description).to eq(asgn.description)
    expect(asgn.event.startime).to    eq(asgn.due)
    expect(asgn.event.endtime).to     eq(asgn.due)
  end
end
