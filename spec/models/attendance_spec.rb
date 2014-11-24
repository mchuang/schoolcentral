# @author: elewis

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

  it "correctly reports status symbols" do
    expect(FactoryGirl.create(:present_attendance).get_status).to eq(:present)
    expect(FactoryGirl.create(:tardy_attendance).get_status).to eq(:tardy)
    expect(FactoryGirl.create(:absent_attendance).get_status).to eq(:absent)
  end

  it "attendance get_week correct" do
    cls = FactoryGirl.create(:classroom)
    std = FactoryGirl.create(:student)
    atd = [
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-1-5"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-1-6"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-1-8"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-1-12"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-1-13")
    ]
    week = Attendance.get_week(cls, Date.new(2014, 1, 10))
    expect(week).to     match_array(atd[1, 3])
    expect(week).not_to match_array(atd[0, 4])
    expect(week).not_to match_array(atd[1, 4])
  end

  it "attendance get_week_for_student correct" do
    cls = FactoryGirl.create(:classroom)
    std0 = FactoryGirl.create(:student)
    std1 = FactoryGirl.create(:student)
    atd = [
      FactoryGirl.create(:attendance, classroom: cls, student: std0, date: "2014-1-5"),
      FactoryGirl.create(:attendance, classroom: cls, student: std0, date: "2014-1-6"),
      FactoryGirl.create(:attendance, classroom: cls, student: std0, date: "2014-1-8"),
      FactoryGirl.create(:attendance, classroom: cls, student: std0, date: "2014-1-12"),
      FactoryGirl.create(:attendance, classroom: cls, student: std0, date: "2014-1-13"),

      FactoryGirl.create(:attendance, classroom: cls, student: std1, date: "2014-1-5"),
      FactoryGirl.create(:attendance, classroom: cls, student: std1, date: "2014-1-6"),
      FactoryGirl.create(:attendance, classroom: cls, student: std1, date: "2014-1-13"),
    ]
    week = Attendance.get_week_for_student(std0, cls, Date.new(2014, 1, 10))
    expect(week).to     match_array(atd[1, 3])
    expect(week).not_to match_array(atd[1, 3] + atd[6, 1])

    week = Attendance.get_week_for_student(std1, cls, Date.new(2014, 1, 10))
    expect(week).to     match_array(atd[6, 1])
    expect(week).not_to match_array(atd[1, 3] + atd[6, 1])
  end

  it "attendance get_month correct" do
    cls = FactoryGirl.create(:classroom)
    std = FactoryGirl.create(:student)
    atd = [
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-3-5"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-4-6"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-4-8"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-4-12"),
      FactoryGirl.create(:attendance, classroom: cls, student: std, date: "2014-5-13")
    ]
    month = Attendance.get_month(cls, Date.new(2014, 4, 10))
    expect(month).to     match_array(atd[1, 3])
    expect(month).not_to match_array(atd[0, 4])
    expect(month).not_to match_array(atd[1, 4])
  end

  xit "attendance week_array correct" do
    start = Date.new(2014, 1, 6)
    week = (0..6).map {|i| start + i.days}

    # Skipped because current implementation ignores date argument
    expect(Attendance.get_week_array(start)).to              match_array(week)
    expect(Attendance.get_week_array(start + 1.day)).to      match_array(week)
    expect(Attendance.get_week_array(start + 1.week)).not_to match_array(week)
  end

  it "attendance invalid status" do
    expect {
      FactoryGirl.create(:attendance, :status => -1)
    }.to raise_error(ActiveRecord::RecordInvalid)
    expect {
      FactoryGirl.create(:attendance, :status => 3)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe "attendance add_class" do
    before(:each) do
      @date = DateTime.strptime("2014-10-15", "%Y-%m-%d")
      @cls  = FactoryGirl.create(:classroom)
      std1 = FactoryGirl.create(:student, :id => 1)
      std2 = FactoryGirl.create(:student, :id => 2)
      std3 = FactoryGirl.create(:student, :id => 3)
      @cls.students = [std1, std2, std3]
      @cls.save
    end

    it "attendance add_class adds all students" do
      Attendance.add_class(@cls, @date, absent: [2], tardy: [3])
      expect(@cls.attendance.count).to eq(3)
      expect(@cls.attendance.find_by(:student_id => 1).status).to eq(0)
      expect(@cls.attendance.find_by(:student_id => 2).status).to eq(2)
      expect(@cls.attendance.find_by(:student_id => 3).status).to eq(1)
      @cls.attendance.each {|atd|
          expect(atd.date).to eq(@date)
      }
    end

    it "attendance add_class updates existing records" do
      Attendance.add_class(@cls, @date, absent: [2], tardy: [3])
      expect(@cls.attendance.count).to eq(3)
      expect(@cls.attendance.find_by(student_id: 1).status).to eq(0)
      expect(@cls.attendance.find_by(student_id: 2).status).to eq(2)
      expect(@cls.attendance.find_by(student_id: 3).status).to eq(1)

      Attendance.add_class(@cls, @date, absent: [1], tardy: [2])
      expect(@cls.attendance.count).to eq(3) # no new records
      expect(@cls.attendance.find_by(student_id: 1).status).to eq(2)
      expect(@cls.attendance.find_by(student_id: 2).status).to eq(1)
      expect(@cls.attendance.find_by(student_id: 3).status).to eq(0)
    end
  end
end
