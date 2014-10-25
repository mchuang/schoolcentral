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

    @class0.teachers << @teacher0.account
    @class0.students << @student0.account
    @class0.students << @student1.account
  end

  it "should report all students" do
    expect(@student0.account.teachers).to match_array([@teacher0.account])
    expect(@student0.account.teachers).not_to match_array(Teacher.all)
  end
end
