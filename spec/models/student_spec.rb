# @author: elewis

require 'rails_helper'

RSpec.describe Student, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @teacher1 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher1")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
    @student1 = FactoryGirl.create(:student_user, email: "", identifier: "student1")
    @student2 = FactoryGirl.create(:student_user, email: "", identifier: "student2")
    @class0   = FactoryGirl.create(:classroom,    name: "class0")
    @class1 = FactoryGirl.create(:classroom, name: "class1")
    @event0 = FactoryGirl.create(:event)
    @event1 = FactoryGirl.create(:event)

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
    @class0.events << @event0

    @class1.teachers << @teacher1.account
    @class1.students << @student1.account
    @class1.events<< @event1

    @assignment0 = FactoryGirl.create(:assignment,
      name: "assg0",
      classroom_id: @class0.id,
      due: Time.zone.now + 3.hours,
      max_points: 30,
    )
    @assignment1 = FactoryGirl.create(:assignment,
      name: "assg1",
      classroom_id: @class0.id,
      due: Time.zone.now + 12.hours,
      max_points: 100,
    )
  end

  it "should report all students" do
    expect(@student0.account.teachers).to match_array([@teacher0.account])
    expect(@student0.account.teachers).not_to match_array(Teacher.all)
  end

  it "should report all events" do 
    expect(@student0.account.events).to match_array([@event0, @assignment0.event, @assignment1.event])
    expect(@student1.account.events).to match_array([@event1])
  end

  it "should correctly retrieve submissions" do
    expect(@student0.account.submission(@assignment0.id)).to eq(
      Submission.find_by(assignment_id: @assignment0.id, student_id: @student0.account_id)
    )
    expect(@student0.account.submission(@assignment1.id)).to eq(
      Submission.find_by(assignment_id: @assignment1.id, student_id: @student0.account_id)
    )
  end

  it "should correctly report received points" do
    @student0.account.submission(@assignment0.id).update(grade: 29)
    @student0.account.submission(@assignment1.id).update(grade: 60)
    expect(@student0.account.recv_points(@class0.id)).to eq(29 + 60)
    expect(@student1.account.recv_points(@class1.id)).to eq(0)
  end

  it "should correctly report grade percentage" do
    @student0.account.submission(@assignment0.id).update(grade: 29)
    @student0.account.submission(@assignment1.id).update(grade: 60)
    expect(@student0.account.grade(@class0.id)).to eq((29+60).to_f / (@assignment0.max_points + @assignment1.max_points))
    expect(@student1.account.grade(@class1.id)).to eq(0.0)
  end
end
