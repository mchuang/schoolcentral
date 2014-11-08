# @author: elewis

require 'rails_helper'

RSpec.describe Classroom, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "name must be unique" do
    expect {
      FactoryGirl.create(:classroom)
      FactoryGirl.create(:classroom)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "student capacity must be >= 0" do
    expect {
      FactoryGirl.create(:classroom, :student_capacity => -1)
    }.to raise_error(ActiveRecord::RecordInvalid)
    expect {
      FactoryGirl.create(:classroom, :student_capacity => 0)
    }.not_to raise_error
  end

  it "students must not exceed capacity" do
    cls = FactoryGirl.create(:classroom, :student_capacity => 2)
    cls.students << FactoryGirl.create(:student)
    cls.students << FactoryGirl.create(:student)
    expect { cls.save! }.not_to raise_error
    cls.students << FactoryGirl.create(:student)
    expect { cls.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should correctly aggregate assignment points" do
    total_points = 0
    cls = FactoryGirl.create(:classroom)
    expect(cls.max_points).to eq(0)
    (0..5).each {|i|
      assgn = FactoryGirl.create(:assignment,
        :name => "assgn-#{i}",
        :max_points => i*5,
        :classroom => cls
      )
      total_points += assgn.max_points
    }
    expect(cls.max_points).to eq(total_points)
  end

  it "current assignments returns current and past gets past" do
    cls = FactoryGirl.create(:classroom)
    asn0 = FactoryGirl.create(:assignment, :classroom =>cls, :due => DateTime.new(2013,2,3))
    asn1 = FactoryGirl.create(:assignment, :classroom =>cls, :due => DateTime.new(2015,2,3))
    expect(cls.current_assignments).to eq([asn1])
    expect(cls.past_assignments).to eq([asn0])
  end
end
