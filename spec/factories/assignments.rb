# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    teacher
    classroom
    name        "MyString"
    description "MyString"
    due { Time.zone.now + 3.hours }
  end
end
