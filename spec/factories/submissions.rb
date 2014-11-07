# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    filename "MyString"
    assignment
    student
  end
end
