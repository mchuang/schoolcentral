# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :submission do
    filename "MyString"
    assignment 
    student
    file nil
  end

  factory :file_submission, parent: :submission do
    file Rack::Test::UploadedFile.new(Rails.root.join("spec/testfile/hw.pdf"))
  end
end
