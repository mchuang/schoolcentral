# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher do
    user_id 1
    account_type "teacher"
  end
end
