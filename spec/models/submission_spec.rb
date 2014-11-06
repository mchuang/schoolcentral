require 'rails_helper'

RSpec.describe Submission, :type => :model do
  
  it "should correctly test if graded" do
    sub = FactoryGirl.create(:submission, :grade => nil)
    expect(sub.graded?).to eq(false)
    sub.update(:grade => 0)
    expect(sub.graded?).to eq(true)
    sub.update(:grade => 30)
    expect(sub.graded?).to eq(true)
  end

  it "should correctly error on negative grade" do
    expect {
        FactoryGirl.create(:submission, :grade => -1)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
