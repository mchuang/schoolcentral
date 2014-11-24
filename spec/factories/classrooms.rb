# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    name "MyString"
    time ""
    location "MyString"
    description "MyString"
    school {
      School.find_by_identifier("ths") || FactoryGirl.create(:school, identifier: "ths")
    }
  end
end
