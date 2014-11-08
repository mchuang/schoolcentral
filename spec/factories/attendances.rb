# @author: elewis

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance do
    student_id 1
    classroom_id 1
    date "2014-10-14"
    status 0
  end

  factory :present_attendance, parent: :attendance do
    student_id 1
    classroom_id 1
    date "2014-10-14"
    status 0
  end

  factory :tardy_attendance, parent: :attendance do
    student_id 1
    classroom_id 1
    date "2014-10-15"
    status 1
  end

  factory :absent_attendance, parent: :attendance do
    student_id 1
    classroom_id 1
    date "2014-10-16"
    status 2
  end
end
