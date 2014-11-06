# @author: elewis

require 'rails_helper'

RSpec.describe School, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @school0 = FactoryGirl.create(:school)
    @admin0 = FactoryGirl.create(:admin_user, :school_id => @school0.id)
    @teacher0 = FactoryGirl.create(:teacher_user, :school_id => @school0.id)
    @student0 = FactoryGirl.create(:student_user, :school_id => @school0.id)
  end

  it "name must be unique" do
    expect {
      FactoryGirl.create(:school, :name => "school1")
      FactoryGirl.create(:school, :name => "school1")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should correctly report admins" do
    expect(@school0.admins).to match_array([@admin0.account])
  end

  it "should correctly report teachers" do
    expect(@school0.teachers).to match_array([@teacher0.account])
  end

  it "should correctly report students" do
    expect(@school0.students).to match_array([@student0.account])
  end
end
