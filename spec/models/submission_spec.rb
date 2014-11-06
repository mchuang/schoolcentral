require 'rails_helper'


RSpec.describe Submission, :type => :model do
 
  before do
   	@file = File.new(Rails.root+"testfiles/hw.pdf","a")
   	@submission = FactoryGirl.create(:submission)
   	@submission.file = @file
  end
  it "should have an attachment"  do
  	expect(@submission.file).to eq(@file)
  end

  # :rails_root/public/system/:class/:attachment/:id_partition/:style/:filename
end
