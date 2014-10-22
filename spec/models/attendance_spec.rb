require 'rails_helper'

RSpec.describe Attendance, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "attendance correctly reports present status" do
    att = FactoryGirl.create(:present_attendance)
    expect(att.present?).to eq(true)
    expect(att.tardy?).to eq(false)
    expect(att.absent?).to eq(false)
  end

  it "attendance correctly reports tardy status" do
    att = FactoryGirl.create(:tardy_attendance)
    expect(att.present?).to eq(false)
    expect(att.tardy?).to eq(true)
    expect(att.absent?).to eq(false)
  end

  it "attendance correctly reports absent status" do
    att = FactoryGirl.create(:absent_attendance)
    expect(att.present?).to eq(false)
    expect(att.tardy?).to eq(false)
    expect(att.absent?).to eq(true)
  end

  it "attendance get_week correct" do
    cls = FactoryGirl.create(:classroom)
    std = FactoryGirl.create(:student)
    atd = [
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-1-5"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-1-6"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-1-8"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-1-12"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-1-13")
    ]
    week = Attendance.get_week(cls, Date.new(2014, 1, 10))
    expect(week).to     match_array(atd[1, 3])
    expect(week).not_to match_array(atd[0, 4])
    expect(week).not_to match_array(atd[1, 4])
  end

  it "attendance get_month correct" do
    cls = FactoryGirl.create(:classroom)
    std = FactoryGirl.create(:student)
    atd = [
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-3-5"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-4-1"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-4-8"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-4-30"),
      FactoryGirl.create(:attendance, classroom_id: cls.id, student_id: std.id, date: "2014-5-13")
    ]
    month = Attendance.get_month(cls, Date.new(2014, 4, 10))
    expect(month).to     match_array(atd[1, 3])
    expect(month).not_to match_array(atd[0, 4])
    expect(month).not_to match_array(atd[1, 4])
  end

  it "attendance add_class adds all students" do
    date = "2014-10-15"
    cls  = FactoryGirl.create(:classroom)
    std1 = FactoryGirl.create(:student, :id => 1)
    std2 = FactoryGirl.create(:student, :id => 2)
    std3 = FactoryGirl.create(:student, :id => 3)
    cls.students = [std1, std2, std3]
    cls.save

    Attendance.add_class(cls, date, absent: [2], tardy: [3])
    expect(cls.attendance.count).to eq(3)
    expect(cls.attendance.find_by(:student_id => 1).status).to eq(0)
    expect(cls.attendance.find_by(:student_id => 2).status).to eq(2)
    expect(cls.attendance.find_by(:student_id => 3).status).to eq(1)
    cls.attendance.each {|atd|
        expect(atd.date.strftime("%F")).to eq(date)
    }
  end
end
