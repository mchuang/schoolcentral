require 'rails_helper'

RSpec.describe Admin, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @school0 = FactoryGirl.create(:school, name: "school0")
    @school1 = FactoryGirl.create(:school, name: "school1")
    @admin0 = FactoryGirl.create(:admin_user, email: "", school: @school0, identifier: "admin0")
    @admin1 = FactoryGirl.create(:admin_user, email: "", school: @school1, identifier: "admin1")
    
    @student0 = FactoryGirl.create(:student_user, email: "", school: @school0, identifier: "student0")
    @student1 = FactoryGirl.create(:student_user, email: "", school: @school0, identifier: "student1")
   
    @class0 = FactoryGirl.create(:classroom, name: "class0", school: @school0)
    @class1 = FactoryGirl.create(:classroom, name: "class1", school: @school1)
    
    @event0 = FactoryGirl.create(:event)
    @event1 = FactoryGirl.create(:event)
    @event2 = FactoryGirl.create(:event)

    @class0.students << @student0.account
    @class0.students << @student1.account
    @class0.events << @event0
    @class0.events << @event1

    @class1.events << @event2
  end

  it "should report all events " do 
    expect(@admin0.account.events).to match_array([@event0, @event1])
    expect(@admin1.account.events).to match_array([@event2])
  end 
end
