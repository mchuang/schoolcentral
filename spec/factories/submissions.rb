# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :submission do
    filename "MyString"
    grade 1
    assignment_id 1
    student_id 1
  end
end
