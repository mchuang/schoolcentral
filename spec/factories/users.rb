# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	identifier             "123456"
  	email                  "pat@place.edu"
  	first_name             "Pat"
  	last_name              "Smith"
    password               "password"
    password_confirmation  "password"
  end
end
