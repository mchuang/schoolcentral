require 'rails_helper'

RSpec.describe School, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "name must be unique" do
    expect {
      FactoryGirl.create(:school)
      FactoryGirl.create(:school)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
