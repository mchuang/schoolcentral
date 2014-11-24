require 'rails_helper'

RSpec.describe Event, :type => :model do

  describe "event time fetchers" do
    before(:each) do
      @classroom = FactoryGirl.create(:classroom)
      @student0 = FactoryGirl.create(:student_user)
      @teacher0 = FactoryGirl.create(:teacher_user)
      @events = []
      @now = Time.zone.now
      offsets = [1.minute, 1.hour, 1.day, 1.week, 1.month]
      offsets.each_with_index do |offset, i|
          asgn = FactoryGirl.create(:assignment,
              name: "asgn-#{i}",
              classroom: @classroom,
              teacher: @teacher0.account,
              due: @now + offset
          )
          @events << asgn.event
      end

      @classroom.students << @student0.account
      @classroom.teachers << @teacher0.account
    end

    it "should correctly report one day's events" do
      day = Event.get_day(@student0.account, Time.zone.now)
      expect(day).to     match_array(@events[0, 2])
      expect(day).not_to match_array(@events[0, 3])

      day = Event.get_day(@student0.account, Time.zone.now + 1.week)
      expect(day).to     match_array(@events[3, 1])
      expect(day).not_to match_array(@events[2, 2])
    end

    it "should correctly report one week's events" do
      week = Event.get_week(@student0.account, Time.zone.now)
      expect(week).to     match_array(@events[0, 3])
      expect(week).not_to match_array(@events[0, 4])

      week = Event.get_week(@student0.account, Time.zone.now + 1.week)
      expect(week).to     match_array(@events[3, 1])
      expect(week).not_to match_array(@events[2, 2])
    end

    xit "should correctly report one month's events" do
      month = Event.get_month(@student0.account, Time.zone.now)
      expect(month).to     match_array(@events[0, 4])
      expect(month).not_to match_array(@events[0, 5])

      month = Event.get_month(@student0.account, Time.zone.now + 1.month)
      expect(month).to     match_array(@events[4, 1])
      expect(month).not_to match_array(@events[3, 2])
    end
  end

  describe "personal reminder events" do
    before(:each) do
      @class0 = FactoryGirl.create(:classroom)
      @student0 = FactoryGirl.create(:student_user)
      @teacher0 = FactoryGirl.create(:teacher_user)

      @asgn = FactoryGirl.create(:assignment,
        name: "test-asgn",
        classroom: @class0,
        teacher: @teacher0.account,
        due: Time.zone.now
      )
      @class0.teachers << @teacher0.account
      @class0.students << @student0.account
      @tch_reminder = FactoryGirl.create(:reminder, owner: @teacher0.account)
      @std_reminder = FactoryGirl.create(:reminder, owner: @student0.account)
    end

    it "should include student reminder" do
      expect(@student0.account.events).to match_array([@asgn.event, @std_reminder])
    end

    it "should include teacher reminder" do
      expect(@teacher0.account.events).to match_array([@asgn.event, @tch_reminder])
    end

    it "should show all non reminders" do
      @student1 = FactoryGirl.create(:student_user, email: "", identifier: "1")
      @class0.students << @student1.account
      expect(@student1.account.events).to match_array([@asgn.event])
    end

    it "should allow empty reminders" do
      @student1 = FactoryGirl.create(:student_user, email: "", identifier: "1")
      expect(@student1.account.events).to match_array([])
    end
  end
end
