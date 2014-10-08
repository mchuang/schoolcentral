# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    name "MyString"
    time ""
    location "MyString"
    description "MyString"
    student_capacity 1
  end
end
