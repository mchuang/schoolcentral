# @author: elewis

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    identifier             "123456"
    email                  "pat@fake.com"
    first_name             "Pat"
    last_name              "Smith"
    password               "password"
    password_confirmation  "password"
  end

  factory :admin_user, parent: :user do
    identifier "admin_factory"
    email "admin_factory@fake.com"
    first_name "admin"
    last_name "factory"
    association :account, factory: :admin
  end

  factory :teacher_user, parent: :user do
    identifier "teacher_factory"
    email "teacher_factory@fake.com"
    first_name "teacher"
    last_name "factory"
    association :account, factory: :teacher
  end

  factory :student_user, parent: :user do
    identifier "student_factory"
    email "student_factory@fake.com"
    first_name "student"
    last_name "factory"
    association :account, factory: :student
  end
end
