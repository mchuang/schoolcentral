# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "TEST EVENT"
    startime "2014-11-02 14:33:32"
    endtime "2014-11-02 14:33:32"
    description "TESTING description"
    classroom_id 1
  end

  factory :reminder, parent: :event do
    name "TEST PERSONAL REMINDER"
    startime "2014-11-02 14:33:32"
    endtime "2014-11-02 14:33:32"
    description "Personal reminder"
  end
end
