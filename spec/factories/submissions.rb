# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :submission do
    filename "MyString"
    assignment 
    student
    file Rack::Test::UploadedFile.new(Rails.root.join("spec/testfile/hw.pdf"))
  end
end
