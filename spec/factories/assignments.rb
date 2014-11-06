# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    teacher_id 1
    classroom_id 1
    max_points 1
    name "MyString"
    description "MyString"
    due (Time.now + 3.hours).to_s
  end
end
