# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    user_id 1
    account_type 'admin'
  end
end
