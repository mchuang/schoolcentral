# @author: elewis

require 'rails_helper'

RSpec.describe Teacher, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @teacher0 = FactoryGirl.create(:teacher_user, email: "", identifier: "teacher0")
    @student0 = FactoryGirl.create(:student_user, email: "", identifier: "student0")
    @student1 = FactoryGirl.create(:student_user, email: "", identifier: "student1")
    @student2 = FactoryGirl.create(:student_user, email: "", identifier: "student2")
    @class0   = FactoryGirl.create(:classroom,    name: "class0")

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
    @class0.students << @student1.account
  end

  it "should report all students" do
    expect(@teacher0.account.students).to match_array([@student0.account, @student1.account])
    expect(@teacher0.account.students).not_to match_array(Student.all)
  end
end
